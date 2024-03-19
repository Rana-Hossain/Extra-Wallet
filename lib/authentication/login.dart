import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import '../home.dart';
import 'signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final _auth= FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/login.png'), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              padding:const EdgeInsets.only(left: 35, top: 150),
              child: const Text(
                'Welcome\nBack',
                style: TextStyle(color: Colors.white, fontSize: 33),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.5,
                    right: 35,
                    left: 35),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        autofocus: false,
                        controller: _email,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Email Addressed Required");
                          }
                          if (!EmailValidator.validate(value, true)) {
                            return ("Enter Valid Email Addressed");
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _email.text = value!;
                        },
                        textInputAction: TextInputAction.next,
                        //controller: TextEditingController(),
                        decoration: InputDecoration(
                            hintText: 'Email',
                            prefixIcon: const Icon(Icons.mail),
                            fillColor: Colors.grey.shade100,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        autofocus: false,
                        controller: _pass,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Password is required for Signing");
                          }
                          if (value.length < 6) {
                            return ("Minimum 6 character Required");
                          }
                          // if(!RegExp(r'^.{5,}&').hasMatch(value)){
                          //   return ("Password required minimum 6 character");
                          // }
                        },
                        onSaved: (value) {
                          _pass.text = value!;
                        },
                        textInputAction: TextInputAction.next,
                        obscureText: true,
                        //controller: TextEditingController(),
                        decoration: InputDecoration(
                            hintText: 'Password',
                            prefixIcon: const Icon(Icons.lock),
                            fillColor: Colors.grey.shade100,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const SizedBox(
                        width: 350,
                        child: Text(
                          'Forgot your password?',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontSize: 14),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      MaterialButton(
                        color: Colors.lightBlue,
                        minWidth: 120,
                        height: 50,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        onPressed: () {
                          if(_formkey.currentState!.validate()){
                            _auth.signInWithEmailAndPassword(email: _email.text, password: _pass.text)
                                .then((uid) =>{
                                  Fluttertoast.showToast(msg: "Login Successfully"),
                            Navigator.push(context,MaterialPageRoute(builder: (context)=> const Home())),
                            }).catchError((e){
                              Fluttertoast.showToast(msg: "Invalid Email or Password");
                            });
                          }
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      RichText(
                        text: TextSpan(
                            text: 'Don\'t have an account?',
                            style: TextStyle(
                                color: Colors.grey.shade700, fontSize: 18),
                            children: [
                              TextSpan(
                                  text: ' Create',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(context,MaterialPageRoute(builder: (context) => const Signup()));
                                    })
                            ]),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
