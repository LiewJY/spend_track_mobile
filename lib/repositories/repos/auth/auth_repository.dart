import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:track/repositories/models/user.dart';

class AuthRepository {
  //create firebase auth instance
  final firebase_auth.FirebaseAuth _firebaseAuth;
  AuthRepository({firebase_auth.FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  //init as empty
  var currentUser = User.empty;

  //return a stream of the current user
  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? User.empty : firebaseUser.toUser;
      //return the mapped user
      return user;
    });
  }

  // //register
  Future<void> register(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (_) {}
  }

  //login
  Future<void> loginWithCredentials(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on firebase_auth.FirebaseAuthException catch (e) {
      log(" e   ${e.code}");
      log(" e   ${e.message}");
      throw e.code;
    } catch (_) {
      throw "unknown";
    }
  }

  //logout
  Future<void> logout() async {
    try {
      await Future.wait([_firebaseAuth.signOut()]);
    } catch (e) {
      throw Exception(e);
    }
  }

  //todo google login and link with account
  //google login
}

extension on firebase_auth.User {
  //map firebase user to user model
  User get toUser {
    return User(id: uid, email: email, name: displayName);
  }
}
