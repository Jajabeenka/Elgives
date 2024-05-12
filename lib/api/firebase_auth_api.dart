import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ito yung class
class FirebaseAuthAPI {
  // instantiate a new instance
  static final FirebaseAuth auth = FirebaseAuth.instance;

// lahat ng details ng LOGGED IN user andito na
  User? getUser() {
    return auth.currentUser;
  }

// chinecheck kung may naka sign in o wala
  Stream<User?> userSignedIn() {
    return auth.authStateChanges();
  }

  Future<String?> signIn(String email, String password) async {
    // UserCredential credential;
    try {
       await auth.signInWithEmailAndPassword(
          email: email, password: password);
          return "";
//let's print the object returned by signInWithEmailAndPassword
//you can use this object to get the user's id, email, etc.
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
//possible to return something more useful
//than just print an error message to improve UI/UX
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future<void> signUp(String email, String password, String fname, String lname) async {
    UserCredential credential;
    try {
      // papasa lang paggawa method
      credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password, 
      );
      // add fname and lname
    await FirebaseFirestore.instance.collection('users').doc(credential.user!.uid).set({
      'firstName': fname,
      'lastName': lname,
      'email': email,
    });

//let's print the object returned by signInWithEmailAndPassword
//you can use this object to get the user's id, email, etc.\
      print(credential);
    } on FirebaseAuthException catch (e) {
//possible to return something more useful
//than just print an error message to improve UI/UX
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }else if (e.code == 'invalid-email') {
        print('Invalid email address');
      }
    } catch (e) {
      print(e);
    }
  }
Future<void> signOut() async {
  await auth.signOut();
}
}


// kung magkaiba ang iaaccess 
// authentication only