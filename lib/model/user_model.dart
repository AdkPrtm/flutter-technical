import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String id, name, email;
  final bool verified;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.verified,
  });
  UserModel copyWith({required bool verified}) => UserModel(
        id: id,
        name: name,
        email: email,
        verified: verified,
      );

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
      id: document.id,
      name: data['name'],
      email: data['email'],
      verified: data['verified'],
    );
  }

  @override
  List<Object?> get props => [id, name, email, verified];
}
