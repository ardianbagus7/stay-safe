part of 'extensions.dart';

extension FirebaseUserExtension on FirebaseUser {
  User convertToUser({String name = "No Name", String role}) => User(
        this.uid,
        this.email,
        name: name,
        role: role,
      );

  Future<User> fromFireStore() async =>
      await UserServices.getUser(this.uid);
}
