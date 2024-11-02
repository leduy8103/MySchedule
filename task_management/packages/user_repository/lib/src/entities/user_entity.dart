import 'dart:math';

class MyUserEntity {
  String userId;
  String email;
  String name;
  String phoneNumber;
  String dob;
  bool hasSyncWithGoogleCalendar;

  MyUserEntity(
      {required this.userId,
      required this.email,
      required this.name,
      required this.phoneNumber,
      required this.dob,
      required this.hasSyncWithGoogleCalendar});

  Map<String, Object?> toDocument() {
    return {
      'userId': userId,
      'email': email,
      'name': name,
      'phoneNumber': phoneNumber,
      'dob': dob,
      'hasSyncWithGoogleCalendar': hasSyncWithGoogleCalendar,
    };
  }

  static MyUserEntity fromDocument(Map<String, dynamic> doc) {
    return MyUserEntity(
      userId: doc['userId'],
      email: doc['email'],
      name: doc['name'],
      phoneNumber: doc['phoneNumber'],
      dob: doc['dob'],
      hasSyncWithGoogleCalendar: doc['hasSyncWithGoogleCalendar'],
    );
  }
}
