import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';

import '../home.dart';
import 'login.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});
  
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/register.png'), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 35, top: 150),
              child: const Text(
                'Create\nAccount',
                style: TextStyle(color: Colors.white, fontSize: 33),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.4,
                    right: 35,
                    left: 35),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        autofocus: false,
                        controller: _name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("PLease Enter Your Name");
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _name.text = value!;
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.white)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.white)),
                            hintText: 'Name',
                            hintStyle: const TextStyle(color: Colors.white),
                            prefixIcon:
                                const Icon(Icons.account_circle_outlined),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
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
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.white)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.white)),
                            hintText: 'Email',
                            hintStyle: const TextStyle(color: Colors.white),
                            prefixIcon: const Icon(Icons.mail),
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
                        textInputAction: TextInputAction.done,
                        obscureText: true,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.white)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    const BorderSide(color: Colors.white)),
                            hintText: 'Password',
                            hintStyle: const TextStyle(color: Colors.white),
                            prefixIcon: const Icon(Icons.lock),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      const SizedBox(
                        height: 30,
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
                          if (_formkey.currentState!.validate()) {
                            Map<String, dynamic> data = {
                              "name": _name.text,
                              "email": _email.text,
                              "pass": _pass.text,
                              "Balance": "0",
                              "address":"",
                              "number":"",
                              "clickADtask":"16",
                              "clickVDtask":"16"
                            };
                            // FirebaseFirestore.instance.collection("user_data").add(data);

                            _auth
                                .createUserWithEmailAndPassword(email: _email.text, password: _pass.text)
                                .then((value) => {
                                      FirebaseFirestore.instance
                                          .collection("user_data")
                                          .doc(value.user?.uid)
                                          .set(data),

                                      Fluttertoast.showToast(
                                          msg: "Registration Successfully"),

                                      Navigator.push(context,MaterialPageRoute(builder: (context)=> const Home())),
                                    })
                                .catchError((e) {
                              Fluttertoast.showToast(
                                  msg: "Check Your Email and Password");
                            });
                          }
                          //FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email.text, password:
                          //_pass.text).then((value){
                          // print('Registered successfully');
                          //Navigator.push(context,MaterialPageRoute(builder: (context)=> home()));
                          //}).onError((error, stackTrace){
                          //   print('Registration Failed');
                          // });
                        },
                        child: const Text(
                          'Signup',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      RichText(
                          text: TextSpan(
                              text: 'Already have an account?',
                              style: TextStyle(
                                  color: Colors.grey.shade800, fontSize: 18),
                              children: [
                                TextSpan(
                                    text: ' Login',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(context,MaterialPageRoute(builder: (context)=> Login()));
                                      }
                                )
                          ])),
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
