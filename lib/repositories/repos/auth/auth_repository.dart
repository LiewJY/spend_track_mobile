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
    //var user;
    var firebaseUser = _firebaseAuth.currentUser;

    //return User(id: firebaseUser?.uid, email: firebaseUser?.email, name: firebaseUser?.displayName);

    return _firebaseAuth.userChanges().map((firebaseUser) {
      final currentUser =
          firebaseUser == null ? User.empty : firebaseUser.toUser;
      //return the mapped user
      return currentUser;
    });
  }

  //sign up
  Future<void> signUp(
      {required String email,
      required String password,
      required String name}) async {
    //firebase_auth.UserCredential authRegisterResult;
    try {
      var authRegisterResult = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      await authRegisterResult.user?.updateDisplayName(name).whenComplete(() => authRegisterResult.user?.reload());
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw e.code;
    } catch (_) {
      throw "unknown";
    }
  }

  //login
  Future<void> loginWithCredentials(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw e.code;
    } catch (_) {
      throw "unknown";
    }
  }

  //logout
  Future<void> logout() async {
    try {
      currentUser = User.empty;
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
