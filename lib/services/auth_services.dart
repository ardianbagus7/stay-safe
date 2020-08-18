part of 'services.dart';

class AuthServices {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<SignInSignUpResult> signUp(
    String email,
    String password,
    String name,
    String role,
  ) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      User user = result.user.convertToUser(
        name: name,
        role: role,
      );
      String picture = "https://firebasestorage.googleapis.com/v0/b/hackaton-imhf.appspot.com/o/login.png?alt=media&token=d359bfd1-db76-4452-8e41-3a37f5a13d17";
      await UserServices.updateUser(user.copyWith(profilePicture: picture));

      return SignInSignUpResult(user: user);
    } catch (e) {
      return SignInSignUpResult(
          message: e.toString().split(',')[1].trim());
    }
  }

  static Future<SignInSignUpResult> signIn(
      String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      User user = await result.user.fromFireStore();

      return SignInSignUpResult(user: user);
    } catch (e) {
      return SignInSignUpResult(
          message: e.toString().split(',')[1].trim());
    }
  }

  static Future<void> signOut() async {
    await _auth.signOut();
  }

  static Stream<FirebaseUser> get userStream =>
      _auth.onAuthStateChanged;
}

class SignInSignUpResult {
  User user;
  String message;

  SignInSignUpResult({this.user, this.message});
}
