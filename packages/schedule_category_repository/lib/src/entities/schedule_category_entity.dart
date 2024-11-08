import 'package:flutter/material.dart';

class ScheduleCategoryEntity {
  int categoryID;
  String categoryName;
  Color color;
  String userID;

  ScheduleCategoryEntity({
    required this.categoryID,
    required this.categoryName,
    required this.color,
    required this.userID,
  });

  Map<String, Object?> toDocument() {
    return {
      'categoryID': categoryID,
      'categoryName': categoryName,
      'color': color,
      'userID': userID,
    };
  }

  static ScheduleCategoryEntity fromDocument(Map<String, dynamic> doc) {
    return ScheduleCategoryEntity(
      categoryID: doc['categoryID'],
      categoryName: doc['categoryName'],
      color: doc['color'],
      userID: doc['userID'],
    );
  }
}
