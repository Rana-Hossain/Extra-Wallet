import 'package:back_pressed/back_pressed.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'profile.dart';

class EditeProfile extends StatefulWidget {
  //const EditeProfile({super.key});

  String imageURL;
  EditeProfile({required this.imageURL});

  @override
  State<EditeProfile> createState() => _EditeProfileState();
}

class _EditeProfileState extends State<EditeProfile> {

  final _formkey= GlobalKey<FormState>();
  final TextEditingController _name= new TextEditingController();
  final TextEditingController _email= new TextEditingController();
  final TextEditingController _number= new TextEditingController();
  final TextEditingController _address= new TextEditingController();

  XFile? file;
  String? selectedFile;

  String name="Loading...";
  String email="Loading...";
  String address="Update Address";
  String number="Update Number";

  late PickedFile imageFile;
  final ImagePicker picker = ImagePicker();

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

  @override
  void initState(){
    getData();
    super.initState();
  }

  void _showPicker(BuildContext context) {
    showModalBottomSheet(
      //backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.15,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: Wrap(
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                ListTile(
                    leading: const Icon(
                      Icons.photo_library,
                    ),
                    title: const Text(
                      'Gallery',
                      style: TextStyle(),
                    ),
                    onTap: () {
                      _selectFile(true);
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(
                    Icons.photo_camera,
                  ),
                  title: const Text(
                    'Camera',
                    style: TextStyle(),
                  ),
                  onTap: () {
                    _selectFile(false);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _selectFile(bool imageFrom) async {
    file = (await ImagePicker().pickImage(
      source: imageFrom? ImageSource.gallery: ImageSource.camera,
    ))!;
    if(file!=null){
      setState(() {
        selectedFile = file!.name;
      });
    }
  }

  uploadFILE() async {
    try{
      
      firebase_storage.UploadTask uploadTask;
      String? id = FirebaseAuth.instance.currentUser?.uid;
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref().child('User_Profile_Pic').child(id!).child(id);
      uploadTask = ref.putFile(File(file!.path));

      await uploadTask.whenComplete(() => null);
      String imagreUrl = await ref.getDownloadURL();

    }catch(e){
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return OnBackPressed(
      perform: (){
        Navigator.push(context,MaterialPageRoute(builder: (context)=> const Profile()));
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 21, 187, 216),
            centerTitle: true,
            title: const Text('My Profile'),
            //backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        body: Form(
          key: _formkey,
          child: Container(
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
                  const SizedBox(height: 30,),
                  buildTextField("Name",name,false,_name),
                  //buildTextField("Email",email,false,_email),
                  buildTextField("Number",number,false,_number),
                  //buildTextField("Password",pass,true,_pass),
                  //buildTextField("New Password",pass,true,_newpass),
                  buildTextField("Address",address,false,_address),
                  const SizedBox(height: 30,),
                  ElevatedButton(
                    onPressed: ()async{
                      uploadFILE();
                      await FirebaseFirestore.instance.collection("user_data").doc(FirebaseAuth.instance.currentUser!.uid).update({
                          'name': _name.text.isNotEmpty?_name.text.trim(): name.trim(),
                          'email': _email.text.isNotEmpty? _email.text.trim() : email.trim(),
                          'number': _number.text.isNotEmpty? _number.text.trim(): number.trim(),
                          'address': _address.text.isNotEmpty? _address.text.trim(): address.trim(),
                        }
                        ).then((value) => {
                        });
                      //}
                      Fluttertoast.showToast(msg: "Profile Update Successfully");
                    },
                    child: const Text("Save",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,letterSpacing: 2,color: Colors.black),),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 40, 244, 172),
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      ),
                  ),
                  const SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=> Profile()));
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
      ),
    );
  }

  Widget buildTextField(String labelText, String placeholder, bool isPassTextField,TextEditingController _controller){
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: _controller,
        onSaved: (value){
            _controller.text=value!;
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(bottom: 5),
            labelText: labelText,
            labelStyle: const TextStyle(fontSize: 20),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
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
          child: selectedFile==null? Image(image: NetworkImage(widget.imageURL),fit: BoxFit.fill,)
              : Image.file(
            File(file!.path),
            height: 340,
            width: 340,

            fit: BoxFit.fill,
          ),
          //backgroundImage:  AssetImage("assets/demo_profile.jpg")

        ),
        Positioned(
          height: 275,
          left: 90,
          child: MaterialButton(
            onPressed: (){
              _showPicker(context);
            },
            child: const Icon(
              Icons.camera_alt,
              color: Colors.teal,
              size: 28,
            ),
          ),
        )
      ],
    );
  }
}