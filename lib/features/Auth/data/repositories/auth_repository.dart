import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

class AuthRepository {
  final firebase_auth.FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign In
  Future<User?> signIn(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final firebase_auth.User? firebaseUser = userCredential.user;
      if (firebaseUser != null) {
        // Fetch user data from Firestore
        final userDoc =
            await _firestore.collection('users').doc(firebaseUser.uid).get();
        if (userDoc.exists) {
          return User.fromMap(userDoc.data()!);
        }
      }
      return null;
    } catch (e) {
      throw Exception('Failed to sign in: $e');
    }
  }

  // Sign Up
  Future<User?> signUp(String email, String password, String name) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final firebase_auth.User? firebaseUser = userCredential.user;
      if (firebaseUser != null) {
        final appUser = User(id: firebaseUser.uid, email: email, name: name);
        // Save user data to Firestore
        await _firestore
            .collection('users')
            .doc(firebaseUser.uid)
            .set(appUser.toMap());
        return appUser;
      }
      return null;
    } catch (e) {
      throw Exception('Failed to sign up: $e');
    }
  }

  // Reset Password
  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw Exception('Failed to reset password: $e');
    }
  }

  // Get Current User
  Future<User?> getCurrentUser() async {
    final firebase_auth.User? firebaseUser = _auth.currentUser;
    if (firebaseUser != null) {
      final userDoc =
          await _firestore.collection('users').doc(firebaseUser.uid).get();
      if (userDoc.exists) {
        return User.fromMap(userDoc.data()!);
      }
    }
    return null;
  }

  // Sign Out
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
