import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extra_wallet/home.dart';
import 'package:extra_wallet/widget/CustomButtom.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class ClickAD extends StatefulWidget {
  const ClickAD({super.key});

  @override
  State<ClickAD> createState() => _ClickADState();
}

class _ClickADState extends State<ClickAD> {



  late InterstitialAd interstitialAd ;
  bool isAdLoaded = false;
  var adUnit = "ca-app-pub-3940256099942544/1033173712";
  int clickleft=0;
  int earn=0;

  @override
  void initState() {
    // TODO: implement initState
    getclickData();
    initIntersititalAd();
    super.initState();
  }

  getclickData() async {
    User? user= FirebaseAuth.instance.currentUser;
    var value= await FirebaseFirestore.instance.collection("user_data").doc(user?.uid).get();
    setState(() {
      clickleft = int.parse(value.data()!['clickADtask']);
    });
  }

  initIntersititalAd(){
    InterstitialAd.load(
      adUnitId: adUnit,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad){
          interstitialAd = ad;
          setState(() {
            isAdLoaded =true;
          });
        },
          onAdFailedToLoad: ((error){
            interstitialAd.dispose();
          })
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 21, 187, 216),
          centerTitle: true,
          title: const Text("Click Ads"),
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(37),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Today Click Left : $clickleft",style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              const SizedBox(height: 10,),
              Text("Today Total Earn : $earn TK",style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
              const SizedBox(height: 30,),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      if(isAdLoaded){
                        interstitialAd.show();
                        setState(() {
                          clickleft--;
                        });
                        await FirebaseFirestore.instance.collection("user_data").doc(FirebaseAuth.instance.currentUser!.uid).update({
                          'clickADtask': clickleft.toString(),
                        }).then((_) {
                          print('clickADtask updated successfully');
                        }).catchError((error) {
                          print('Failed to update clickADtask: $error');
                        });
                      }
                    },
                    style: primaryStyle,
                    child: const Text(
                      "Ad-1",
                      style: TextStyle(fontSize: 16), // Text style
                    ),
                  ),
                  const SizedBox(width: 30,),
                  ElevatedButton(
                    onPressed: (){
                      
                    },
                    style: primaryStyle,
                    child: const Text(
                      "Ad-2",
                      style: TextStyle(fontSize: 16), // Text style
                    ),
                  ),
                  const SizedBox(width: 30,),
                  ElevatedButton(
                    onPressed: (){
                      
                    },
                    style: primaryStyle,
                    child: const Text(
                      "Ad-3",
                      style: TextStyle(fontSize: 16), // Text style
                    ),
                  )
                ],
              ),
              const SizedBox(height: 30,),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: (){
                      
                    },
                    style: primaryStyle,
                    child: const Text(
                      "Ad-4",
                      style: TextStyle(fontSize: 16), // Text style
                    ),
                  ),
                  const SizedBox(width: 30,),
                  ElevatedButton(
                    onPressed: (){
                      
                    },
                    style: primaryStyle,
                    child: const Text(
                      "Ad-5",
                      style: TextStyle(fontSize: 16), // Text style
                    ),
                  ),
                  const SizedBox(width: 30,),
                  ElevatedButton(
                    onPressed: (){
                      
                    },
                    style: primaryStyle,
                    child: const Text(
                      "Ad-6",
                      style: TextStyle(fontSize: 16), // Text style
                    ),
                  )
                ],
              ),
              const SizedBox(height: 30,),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: (){
                      
                    },
                    style: primaryStyle,
                    child: const Text(
                      "Ad-7",
                      style: TextStyle(fontSize: 16), // Text style
                    ),
                  ),
                  const SizedBox(width: 30,),
                  ElevatedButton(
                    onPressed: (){
                      
                    },
                    style: primaryStyle,
                    child: const Text(
                      "Ad-8",
                      style: TextStyle(fontSize: 16), // Text style
                    ),
                  ),
                  const SizedBox(width: 30,),
                  ElevatedButton(
                    onPressed: (){
                      
                    },
                    style: primaryStyle,
                    child: const Text(
                      "Ad-9",
                      style: TextStyle(fontSize: 16), // Text style
                    ),
                  )
                ],
              ),
              const SizedBox(height: 30,),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: (){
                      
                    },
                    style: primaryStyle,
                    child: const Text(
                      "Ad-10",
                      style: TextStyle(fontSize: 16), // Text style
                    ),
                  ),
                  const SizedBox(width: 17,),
                  ElevatedButton(
                    onPressed: (){
                      
                    },
                    style: primaryStyle,
                    child: const Text(
                      "Ad-11",
                      style: TextStyle(fontSize: 16), // Text style
                    ),
                  ),
                  const SizedBox(width: 17,),
                  ElevatedButton(
                    onPressed: (){
                      
                    },
                    style: primaryStyle,
                    child: const Text(
                      "Ad-12",
                      style: TextStyle(fontSize: 16), // Text style
                    ),
                  )
                ],
              ),
              const SizedBox(height: 30,),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: (){
                      
                    },
                    style: primaryStyle,
                    child: const Text(
                      "Ad-13",
                      style: TextStyle(fontSize: 16), // Text style
                    ),
                  ),
                  const SizedBox(width: 17,),
                  ElevatedButton(
                    onPressed: (){
                      
                    },
                    style: primaryStyle,
                    child: const Text(
                      "Ad-14",
                      style: TextStyle(fontSize: 16), // Text style
                    ),
                  ),
                  const SizedBox(width: 17,),
                  ElevatedButton(
                    onPressed: (){
                      
                    },
                    style: primaryStyle,
                    child: const Text(
                      "Ad-15",
                      style: TextStyle(fontSize: 16), // Text style
                    ),
                  )
                ],
              ),
              const SizedBox(height: 80,),
                ElevatedButton(
                  onPressed: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=> const Home()));
                  },
                  child: const Text("Back",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,letterSpacing: 2),),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 40, 244, 172),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 132),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}