import 'dart:async';
import 'package:flutter/material.dart';
import 'authentication/login.dart';


class SplashServices {
  void isLogin(BuildContext context) {
    Timer(const Duration(seconds: 5,milliseconds: 200),
        ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => const Login()))
    );
  }
}