//Name : Authclass
//Purpose : This class houses the implementation of the createAccount(),  SignIn(),
//          resetPassword() and SignOut() methods that will allow the app to
//          allow users to create accounts, sign in to the app, reset lost passwords,
//          and sign out of the application
import 'package:firebase_auth/firebase_auth.dart';

class AuthClass {
  FirebaseAuth auth = FirebaseAuth.instance;

  //The createAccount() method takes in the parameters of email and password,
  //which is the minmum information that the app will take to create a user account
  //

  Future<String> createAccount({String email, String password}) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      return "Account Created";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
    } catch (e) {
      return 'Error occured';
    }
  }

  //The SignIn() method will take in the email and password parameters which
  //will allow a user to sign into the app

  Future<String> SignIn({String email, String password}) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);

      return 'Welcome';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
    }
  }

  //The resetPassword() method will take be invoked on the user pressing the
  //"forgot password" button and will then send a reset password email to a
  //valid user account

  Future<String> resetPassword({
    String email,
  }) async {
    try {
      await auth.sendPasswordResetEmail(
        email: email,
      );

      return 'Email sent';
    } catch (e) {
      return "Error Occured";
    }
  }

  //The signOut() method will simply sign a user out of the app

  void SignOut() {
    auth.signOut();
  }
}
