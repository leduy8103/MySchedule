// add_category_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:task_management/screens/schedule_category/bloc/add_category/add_category_bloc.dart';
import 'package:user_repository/user_repository.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  _AddCategoryScreenState createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final _categoryNameController = TextEditingController();
  Color _selectedColor = Colors.blue;

  Future<void> _submitCategory() async {
    final userID = await context.read<UserRepository>().getCurrentUID();

    if (userID == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('User ID không xác định. Vui lòng thử lại.')),
      );
      return;
    }

    context.read<AddCategoryBloc>().add(
          SubmitNewCategory(
            categoryName: _categoryNameController.text,
            color: _selectedColor,
            userID: userID,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final userID = context.read<UserRepository>().getCurrentUID();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Category'),
      ),
      body: BlocListener<AddCategoryBloc, AddCategoryState>(
        listener: (context, state) {
          if (state is AddCategorySuccess) {
            Navigator.pop(context); // Go back after successful addition
          } else if (state is AddCategoryFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _categoryNameController,
                decoration: const InputDecoration(labelText: 'Category Name'),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text("Select Color: "),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selectedColor,
                      ),
                      onPressed: () async {
                        final selectedColor = await showDialog<Color>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Pick a color"),
                            content: SingleChildScrollView(
                              child: BlockPicker(
                                pickerColor: _selectedColor,
                                onColorChanged: (color) {
                                  Navigator.pop(context, color);
                                },
                              ),
                            ),
                          ),
                        );
                        if (selectedColor != null) {
                          setState(() {
                            _selectedColor = selectedColor;
                          });
                        }
                      },
                      child: const Text('Select Color'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _submitCategory(),
                child: const Text('Add Category'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
