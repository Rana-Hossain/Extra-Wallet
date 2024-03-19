
import 'package:flutter/material.dart';
import 'splash_services.dart';
class SplashScreen extends StatefulWidget{
  const SplashScreen({key}) : super(key : key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>{

  SplashServices splashScreen = SplashServices();
  void initState(){
    super.initState();
    splashScreen.isLogin(context);
  }

  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xff133337),
      body: Center(
        child: Column(
          children: const [
            SizedBox(height: 250,),
            Image(image: AssetImage("assets/s.gif"),height: 240,width: 400,fit: BoxFit.cover),
            SizedBox(height: 30,),
            Text("Extra Wallet", style: TextStyle(fontSize: 30 , fontWeight: FontWeight.bold , color: Colors.white),),
          ],
        ),
        //child: Text("Amar Pharmacy", style: TextStyle(fontSize: 30 , fontWeight: FontWeight.bold , color: Colors.white),),
      ),
    );
  }
}