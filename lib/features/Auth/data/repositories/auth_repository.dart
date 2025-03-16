import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthRepository {
  final firebase_auth.FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign In
  Future<firebase_auth.User?> signIn(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      throw Exception('Failed to sign in: $e');
    }
  }

  // Sign Up
  Future<firebase_auth.User?> signUp(String email, String password, String name) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final firebase_auth.User? firebaseUser = userCredential.user;
      if (firebaseUser != null) {
        // Save user data to Firestore
        await _firestore.collection('users').doc(firebaseUser.uid).set({
          'id': firebaseUser.uid,
          'email': email,
          'name': name,
        });
      }
      return firebaseUser;
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
  firebase_auth.User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Sign Out
  Future<void> signOut() async {
    await _auth.signOut();
  }
}