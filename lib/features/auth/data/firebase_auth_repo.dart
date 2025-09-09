import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mitra_pix/features/auth/domain/entities/app_user.dart';
import 'package:mitra_pix/features/auth/domain/repo/auth_repo.dart';

class FirebaseAuthRepo implements AuthRepo {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Future<AppUser?> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      // attempt to sign in
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      // create a user

      AppUser user =
          AppUser(uid: userCredential.user!.uid, email: email, name: '');

      //return app user
      return user;
    } catch (e) {
      throw Exception('Login Failed: $e');
    }
  }

  @override
  Future<AppUser?> registerWithEmailAndPassword(
      String name, String email, String password) async {
    try {
      // attempt to sign up
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      // create a user

      AppUser user =
          AppUser(uid: userCredential.user!.uid, email: email, name: name);
      
      // save user data
      await firestore.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'email': user.email,
        'name': user.name,
      });

      //return app user
      return user;
    } catch (e) {
      throw Exception('Login Failed: $e');
    }
  }

  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<AppUser?> getCurrentUser() async {
    //get the current user from firebase auth
    final firebaseUser = firebaseAuth.currentUser;

    // no user logged in..
    if (firebaseUser == null) {
      return null;
    }

    // user exists
    return AppUser(
        uid: firebaseUser.uid, email: firebaseUser.email ?? '', name: '');
  }
}
