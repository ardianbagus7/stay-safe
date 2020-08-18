part of 'services.dart';

class UserServices {
  static CollectionReference _userCollection =
      Firestore.instance.collection('users');

  static Future<bool> updateUser(User user) async {
    try {
      _userCollection.document(user.id).setData({
        'email': user.email,
        'name': user.name,
        'role': user.role,
        'profilePicture': user.profilePicture ?? "",
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  static Future<User> getUser(String id) async {
    DocumentSnapshot snapshot = await _userCollection.document(id).get();

    return User(
      id,
      snapshot.data['email'],
      profilePicture: snapshot.data['profilePicture'],
      role: snapshot.data['role'],
      name: snapshot.data['name'],
    );
  }
}
