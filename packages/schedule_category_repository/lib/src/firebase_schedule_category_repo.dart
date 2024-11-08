import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:schedule_category_repository/src/models/models.dart';
import 'package:schedule_category_repository/src/schedule_category_repo.dart';

class FirebaseScheduleCategoryRepo implements ScheduleCategoryRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> createNew({
    required String categoryName,
    required Color color,
    required String userID,
  }) async {
    // Tạo categoryID tự động bằng cách lấy số lượng tài liệu hiện tại trong collection
    final categoryCountSnapshot =
        await _firestore.collection('categories').get();
    final categoryID =
        categoryCountSnapshot.docs.length + 1; // categoryID sẽ là số tiếp theo

    // Tạo mới một category và thêm vào Firestore
    await _firestore.collection('categories').add({
      'categoryID': categoryID,
      'categoryName': categoryName,
      'color': color.value, // Chuyển đổi màu sắc sang kiểu int
      'userID': userID,
    });
  }

  @override
  Future<void> updateCategory(ScheduleCategory category) async {
    final snapshot = await _firestore
        .collection('categories')
        .where('categoryID', isEqualTo: category.categoryID)
        .get();

    if (snapshot.docs.isNotEmpty) {
      await snapshot.docs.first.reference.update({
        'categoryName': category.categoryName,
        'color': category.color,
      });
    }
  }

  @override
  Future<void> deleteCategory(int categoryID) async {
    final snapshot = await _firestore
        .collection('categories')
        .where('categoryID', isEqualTo: categoryID)
        .get();
    print(snapshot);

    if (snapshot.docs.isNotEmpty) {
      await snapshot.docs.first.reference.delete();
    }
  }

  @override
  Stream<List<Map<String, dynamic>>> getCategories() {
    return _firestore.collection('categories').snapshots().map(
      (snapshot) {
        return snapshot.docs.map((doc) {
          return {
            'categoryID': doc['categoryID'],
            'categoryName': doc['categoryName'],
            'color': doc['color'],
          };
        }).toList();
      },
    );
  }
}
