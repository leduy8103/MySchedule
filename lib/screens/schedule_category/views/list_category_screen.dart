import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/screens/schedule_category/bloc/delete_category/delete_category_bloc.dart';
import 'package:task_management/screens/schedule_category/bloc/get_categories/get_categories_bloc.dart';

class CategoryListScreen extends StatelessWidget {
  const CategoryListScreen({Key? key}) : super(key: key);

  // Hàm để hiển thị hộp thoại xác nhận xóa
  Future<void> _confirmDeleteCategory(
      BuildContext context, int categoryID) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Confirm Deletion'),
        content: const Text('Are you sure you want to delete this category?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    // Nếu người dùng xác nhận xóa
    if (confirm == true) {
      context.read<DeleteCategoryBloc>().add(DeleteCategoryRequest(categoryID));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category List'),
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<DeleteCategoryBloc, DeleteCategoryState>(
            listener: (context, state) {
              if (state is DeleteCategorySuccess) {
                // Hiển thị thông báo khi xóa thành công
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Category deleted successfully')),
                );

                // Tải lại danh sách sau khi xóa
                context.read<GetCategoriesBloc>().add(GetCategoriesRequested());
              } else if (state is DeleteCategoryFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: ${state.error}')),
                );
              }
            },
          ),
        ],
        child: BlocBuilder<GetCategoriesBloc, GetCategoriesState>(
          builder: (context, state) {
            if (state is GetCategoriesInitial) {
              // Lấy danh sách khi lần đầu mở màn hình
              context.read<GetCategoriesBloc>().add(GetCategoriesRequested());
              return const Center(child: CircularProgressIndicator());
            } else if (state is GetCategoriesInProgress) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GetCategoriesSuccess) {
              final categories = state.categories;

              if (categories.isEmpty) {
                return const Center(child: Text('No categories available'));
              }

              return ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final categoryName = category['categoryName'];
                  final categoryID = category['categoryID'];
                  final colorValue = category['color'];
                  final categoryColor = Color(colorValue);

                  return ListTile(
                    title: Text(categoryName),
                    tileColor: categoryColor,
                    textColor: Colors.white,
                    leading: CircleAvatar(
                      backgroundColor: categoryColor,
                      child: Text(
                        categoryName[0].toUpperCase(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.white),
                      onPressed: () {
                        _confirmDeleteCategory(context, categoryID);
                      },
                    ),
                  );
                },
              );
            } else if (state is GetCategoriesFailure) {
              return Center(child: Text('Error: ${state.error}'));
            } else {
              return const Center(child: Text('Unexpected state'));
            }
          },
        ),
      ),
    );
  }
}
