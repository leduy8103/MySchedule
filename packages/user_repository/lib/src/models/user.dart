import 'package:user_repository/src/entities/entities.dart';

class MyUser {
  String userId;
  String email;
  String name;
  String phoneNumber;
  String dob;
  bool hasSyncWithGoogleCalendar;

  MyUser(
      {required this.userId,
      required this.email,
      required this.name,
      required this.phoneNumber,
      required this.dob,
      required this.hasSyncWithGoogleCalendar});

  static final empty = MyUser(
      userId: '',
      email: '',
      name: '',
      phoneNumber: '',
      dob: '',
      hasSyncWithGoogleCalendar: false);

  MyUserEntity toEntity() {
    return MyUserEntity(
      userId: userId,
      email: email,
      name: name,
      phoneNumber: phoneNumber,
      dob: dob,
      hasSyncWithGoogleCalendar: hasSyncWithGoogleCalendar,
    );
  }

  static MyUser fromEntity(MyUserEntity entity) {
    return MyUser(
      userId: entity.userId,
      email: entity.email,
      name: entity.name,
      phoneNumber: entity.phoneNumber,
      dob: entity.dob,
      hasSyncWithGoogleCalendar: entity.hasSyncWithGoogleCalendar,
    );
  }

  @override
  String toString() {
    return 'MyUser: $userId, $email, $name, $phoneNumber, $dob, $hasSyncWithGoogleCalendar';
  }
}
