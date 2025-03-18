import 'package:equatable/equatable.dart';
import 'user_type.dart';

class UserModel extends Equatable {
  final String uid;
  final String name;
  final String email;
  final UserType userType;

  const UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.userType,
  });

  static const empty = UserModel(uid: '', name: '', email: '', userType: UserType.none);

  bool get isEmpty => this == UserModel.empty;
  bool get isNotEmpty => this != UserModel.empty;

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      userType: (map['userType'] as String).toUserType(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'userType': userType.name,
    };
  }

  @override
  List<Object?> get props => [uid, name, email, userType];
}
