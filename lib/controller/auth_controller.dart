import 'package:actfirebase/model/usermdl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('user');

  bool get success => false;

//user model untuk memanggil nama dan mendapatkan datanya
  Future<UserMdl?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential = await auth
          .signInWithEmailAndPassword(email: email, password: password);
      final User? user = userCredential.user;

      if (user != null) {
        final DocumentSnapshot snapshot =
            await userCollection.doc(user.uid).get();

        final UserMdl currentUser = UserMdl(
          uId: user.uid,
          email: user.email ?? '',
          name: snapshot['name'] ?? '',
        );

        return currentUser;
      }
    } catch (e) {
      //
    }
    return null;
  }

  Future<UserMdl?> registerWithEmmailAndPassword(
      String email, String password, String name) async {
    try {
      final UserCredential userCredential = await auth
          .createUserWithEmailAndPassword(email: email, password: password);
      final User? user = userCredential.user;

      if (user != null) {
        final UserMdl newUser = UserMdl(
            uId: user.uid,
            email: user.email ?? '',
            name: name); //untuk validasi teks form

        //create a document in the users collection with the user's UID as the document Id
        await userCollection.doc(newUser.uId).set(newUser.toMap());

        return newUser;
      }
    } catch (e) {
      //
    }
    return null;
  }

  UserMdl? getCurrentUser() {
    final User? user = auth.currentUser;
    if (user != null) {
      return UserMdl.fromFirebaseUser(user);
    }
    return null;
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}
