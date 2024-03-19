import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:back_pressed/back_pressed.dart';

import 'edite_profile.dart';
import 'home.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  late String imageUrl;
  final storage = FirebaseStorage.instance;

  String name="Loading...";
  String email="Loading...";
  String address="Please Update Address";
  String number="Please Update Number";

  void getData() async{
    User? user= FirebaseAuth.instance.currentUser;
    var value= await FirebaseFirestore.instance.collection("user_data").doc(user?.uid).get();
    setState(() {
      name = value.data()!['name'];
      email = value.data()!['email'];
      if(value.data()!['address']!=""){
        address = value.data()!['address'];
      }
      if(value.data()!['number']!=""){
        number = value.data()!['number'];
      }
    });
  }

  Future<void> getProfilePic() async {
    String? id = FirebaseAuth.instance.currentUser?.uid;
    final ref = storage.ref().child('User_Profile_Pic').child(id!).child(id);
    final url = await ref.getDownloadURL();
    setState(() {
      imageUrl=url;
    });
  }

  void initState(){
    imageUrl="https://brsc.sa.edu.au/wp-content/uploads/2018/09/placeholder-profile-sq.jpg";
    getData();
    getProfilePic();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OnBackPressed(
      perform: (){
        Navigator.push(context,MaterialPageRoute(builder: (context)=> Home()));
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 21, 187, 216),
          centerTitle: true,
          title: const Text('My Profile'),
        //backgroundColor: Colors.transparent,
        elevation: 0,
        ),
        body: Container(
          padding: const EdgeInsets.only(left: 15,right: 15,top: 20),
          child: GestureDetector(
            onTap: (){
              FocusScope.of(context).unfocus();
            },
            child: ListView(
              children: [
                Center(
                  child: imageProfile(),
                ),
                const SizedBox(height: 40,),
                buildTextField("Name",name),
                buildTextField("Email",email,),
                buildTextField("Number",number),
                //buildTextField("Password","******",true),
                buildTextField("Address",address),
                const SizedBox(height: 30,),
                ElevatedButton(
                  onPressed: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=> EditeProfile(
                      imageURL: imageUrl,
                    )));
                  },
                  child: const Text("Edit Profile",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,letterSpacing: 2,color: Colors.black),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 40, 244, 172),
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                ),
                const SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=> Home()));
                  },
                  child: const Text("Back",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,letterSpacing: 2,color: Colors.black),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 40, 244, 172),
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget buildTextField(String labelText, String placeholder){
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: TextField(
        enabled:  false,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(bottom: 5),
          labelText: labelText,
          labelStyle: const TextStyle(fontSize: 20),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          hintStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          )
        ),
      ),
    );
  }
  Widget imageProfile(){
    return Stack(
      children: <Widget> [
        Container(
          height: 150,
          width: 150,
          child:  imageUrl==null ? const Image(image: AssetImage("assets/demo_profile.jpg"),fit: BoxFit.fill,)
              : Image(image: NetworkImage(imageUrl),fit: BoxFit.fill,),
          //backgroundImage:  AssetImage("assets/demo_profile.jpg")
        ),
      ],
    );
  }
}
