import 'dart:ui';

import 'package:schedule_category_repository/src/models/models.dart';

abstract class ScheduleCategoryRepo {
  Future<void> createNew({
    required String categoryName,
    required Color color,
    required String userID,
  });

  Future<void> updateCategory(ScheduleCategory category);

  Future<void> deleteCategory(int categoryID);

  Stream<List<Map<String, dynamic>>> getCategories();
}
