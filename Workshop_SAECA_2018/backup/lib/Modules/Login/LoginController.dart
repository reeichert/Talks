import 'package:flutter/material.dart';
import 'package:workshop_chat/Modules/Dashboard/DashboardController.dart';
import 'LoginPage.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginController extends StatefulWidget {
  @override
  _LoginControllerState createState() => _LoginControllerState();
}

class _LoginControllerState extends State<LoginController> {
  LoginState pageState = LoginState.normal;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore _firestore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginPage(
        state: this.pageState,
        onLoginCallback: (name, email, pass) {
          return handleLogin(name, email, pass);
        },
        onRegisterCallback: (name, email, pass) {
          return handleRegister(name, email, pass);
        },
      ),
    );
  }

  handleLogin(String name, String email, String pass) async {
    if (email.isEmpty || pass.isEmpty || name.isEmpty) {
      print('Algo veio vazio');
      return;
    }
    print('tem os dados..');

    setState(() {
      this.pageState = LoginState.loading;
    });

    try {
      print('Iniciando login');
      var user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pass);

      UserUpdateInfo userUpdateInfo = UserUpdateInfo();
      userUpdateInfo.displayName = name;

      await user.updateProfile(userUpdateInfo);

      print('Login feito $user');
      setState(() {
        this.pageState = LoginState.normal;
      });

      if (user != null) {
        _firestore.collection('users').document(user.email).setData({
          'name': name,
          'email': user.email,
          'uid': user.uid,
        });

        logInUser();
      }
    } catch (e) {
      print(e);
      setState(() {
        this.pageState = LoginState.normal;
      });
    }
  }

  handleRegister(String name, String email, String pass) async {
    if (email.isEmpty || pass.isEmpty || name.isEmpty) {
      return;
    }
    setState(() {
      this.pageState = LoginState.loading;
    });

    try {
      var user = await _auth.createUserWithEmailAndPassword(
          email: email, password: pass);

      UserUpdateInfo userUpdateInfo = UserUpdateInfo();
      userUpdateInfo.displayName = name;

      await user.updateProfile(userUpdateInfo);

      setState(() {
        this.pageState = LoginState.normal;
      });

      if (user != null) {
        _firestore.collection('users').document(user.email).setData({
          'name': name,
          'email': user.email,
          'uid': user.uid,
        });
        logInUser();
      }
    } catch (e) {
      print(e);
      setState(() {
        this.pageState = LoginState.normal;
      });
    }
  }

  void logInUser() {
    print('Logando usuario');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (ctx) {
        return DashboardController();
      }),
    );
  }
}
