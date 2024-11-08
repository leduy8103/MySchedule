import 'package:flutter/material.dart';
import 'package:schedule_category_repository/src/entities/entity.dart';

class ScheduleCategory {
  int categoryID;
  String categoryName;
  Color color;
  String userID;

  ScheduleCategory({
    required this.categoryID,
    required this.categoryName,
    required this.color,
    required this.userID,
  });

  static final empty = ScheduleCategory(
      categoryID: 0, categoryName: '', color: Colors.blue, userID: '');

  ScheduleCategoryEntity toEntity() {
    return ScheduleCategoryEntity(
      categoryID: categoryID,
      categoryName: categoryName,
      color: color,
      userID: userID,
    );
  }

  static ScheduleCategory fromEntity(ScheduleCategoryEntity entity) {
    return ScheduleCategory(
      categoryID: entity.categoryID,
      categoryName: entity.categoryName,
      color: entity.color,
      userID: entity.userID,
    );
  }

  @override
  String toString() {
    return 'ScheduleCategory: $categoryID, $categoryName, $color, $userID';
  }
}
