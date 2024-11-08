import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_management/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:schedule_category_repository/schedule_category_repository.dart';
import 'package:task_management/screens/schedule_category/bloc/add_category/add_category_bloc.dart';
import 'package:task_management/screens/schedule_category/bloc/delete_category/delete_category_bloc.dart'; // Import DeleteCategoryBloc
import 'package:task_management/screens/schedule_category/bloc/get_categories/get_categories_bloc.dart';
import 'package:task_management/screens/schedule_category/views/add_schedule_category_screen.dart';
import 'package:task_management/screens/schedule_category/views/list_category_screen.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  void signOut(BuildContext context) {
    context.read<AuthenticationBloc>().add(AuthenticationLogoutRequest());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Colors.purple[50],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => signOut(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                "Sign out",
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Mở AddCategoryScreen với Repository và BLoC
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        RepositoryProvider<ScheduleCategoryRepo>(
                      create: (context) => FirebaseScheduleCategoryRepo(),
                      child: BlocProvider<AddCategoryBloc>(
                        create: (context) => AddCategoryBloc(
                          categoryRepo: context.read<ScheduleCategoryRepo>(),
                        ),
                        child: const AddCategoryScreen(),
                      ),
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                "Add Category",
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Sử dụng DeleteCategoryBloc trong CategoryListScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        RepositoryProvider<ScheduleCategoryRepo>(
                      create: (context) => FirebaseScheduleCategoryRepo(),
                      child: MultiBlocProvider(
                        providers: [
                          BlocProvider<DeleteCategoryBloc>(
                            create: (context) => DeleteCategoryBloc(
                              categoryRepo:
                                  context.read<ScheduleCategoryRepo>(),
                            ),
                          ),
                          BlocProvider<AddCategoryBloc>(
                            create: (context) => AddCategoryBloc(
                              categoryRepo:
                                  context.read<ScheduleCategoryRepo>(),
                            ),
                          ),
                          BlocProvider<GetCategoriesBloc>(
                            create: (context) => GetCategoriesBloc(
                              categoryRepo:
                                  context.read<ScheduleCategoryRepo>(),
                            ),
                          )
                        ],
                        child: const CategoryListScreen(),
                      ),
                    ),
                  ),
                );
              },
              child: const Text('View Categories'),
            ),
          ],
        ),
      ),
    );
  }
}
