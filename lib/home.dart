import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extra_wallet/clickad.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'menu_bar.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String balance = "";

  void getData() async{
    User? user= FirebaseAuth.instance.currentUser;
    var value= await FirebaseFirestore.instance.collection("user_data").doc(user?.uid).get();
    setState(() {
      balance = value.data()!['Balance'];
    });
  }

  @override
  void initState(){
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: Scaffold(
        drawer:  const menubar(),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 21, 187, 216),
          centerTitle: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(
                child: Text('Extra Wallet',textAlign: TextAlign.left,),
              ),
              Expanded(
                child: Text("Bal : $balance TK",textAlign: TextAlign.right,style: TextStyle(fontSize: 17),),
              )
            ],
          )
          
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children:  [
              Image(image: AssetImage("assets/home.gif"),fit: BoxFit.cover),
              SizedBox(height: 40,),
              Row(
                children: [
                  const SizedBox(width: 60,),
                  Center(
                    //heightFactor: 1.5,
                    child: Material(
                      color: Color.fromARGB(255, 186, 224, 240),
                      elevation: 8,
                      borderRadius: BorderRadius.circular(8),
                      clipBehavior: Clip.antiAliasWithSaveLayer,

                      child: InkWell(
                        splashColor: Colors.black,
                        onTap: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context)=> ClickAD()));
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Ink.image(
                                image: const AssetImage('assets/click.png'),height: 85,width: 95,fit: BoxFit.cover,),
                            //SizedBox(height: 10,),
                            const Text('    Click Ads     ', style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),)

                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 60,),
                  Center(
                    //heightFactor: 1.5,
                    child: Material(
                      color: Color.fromARGB(255, 186, 224, 240),
                      elevation: 8,
                      borderRadius: BorderRadius.circular(8),
                      clipBehavior: Clip.antiAliasWithSaveLayer,

                      child: InkWell(
                        splashColor: Colors.black,
                        onTap: (){

                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Ink.image(
                              image: const AssetImage('assets/5311349.png'),height: 85,width: 95,fit: BoxFit.cover,),
                            //SizedBox(height: 10,),
                            const Text('    Video Ads     ', style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                    ),
                  ),

                ],
              ),
              const SizedBox(height: 50,),
              Row(
                children: [
                  const SizedBox(width: 60,),
                  Center(
                    child: Material(
                      color: Color.fromARGB(255, 186, 224, 240),
                      elevation: 8,
                      borderRadius: BorderRadius.circular(8),
                      clipBehavior: Clip.antiAliasWithSaveLayer,

                      child: InkWell(
                        splashColor: Colors.black,
                        onTap: (){

                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Ink.image(
                              image: const AssetImage('assets/3273583.png'),height: 85,width: 85,fit: BoxFit.cover,),
                            //SizedBox(height: 10,),
                            const Text('  Survey Form  ', style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),)

                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 60,),
                  Center(
                    child: Material(
                      color: Color.fromARGB(255, 186, 224, 240),
                      elevation: 8,
                      borderRadius: BorderRadius.circular(8),
                      clipBehavior: Clip.antiAliasWithSaveLayer,

                      child: InkWell(
                        splashColor: Colors.black,
                        onTap: (){

                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            //SizedBox(height: 12,),
                            Ink.image(
                              image: const AssetImage('assets/5024665.png'),height: 85,width: 95,fit: BoxFit.cover,),
                            //SizedBox(height: 12,),
                            const Text('     Withdraw      ', style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}