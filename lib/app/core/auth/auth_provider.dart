import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/app/core/navigator/todo_list_navigator.dart';
import 'package:todo_list/app/services/user/user_services.dart';

class AuthProviderTodo extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth;
  final UserServices _userServices;

  AuthProviderTodo({
    required FirebaseAuth firebaseAuth,
    required UserServices userServices,
  })  : _firebaseAuth = firebaseAuth,
        _userServices = userServices;

  Future<void> logout() {
    return _userServices.logout();
  }

  User? get user => _firebaseAuth.currentUser;

  //Ficar escutando o firebase ao longo da aplicação
  void loadListener() {
    _firebaseAuth.userChanges().listen((event) => notifyListeners());
    _firebaseAuth.authStateChanges().listen((user) {
      if (user != null) {
        TodoListNavigator.to.pushNamedAndRemoveUntil('/home', (route) => false);
      } else {
        TodoListNavigator.to
            .pushNamedAndRemoveUntil('/login', (route) => false);
      }
    });
  }
}
