import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:workmanager/workmanager.dart';
import 'home.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    try {
      // Get the current user ID
      String? userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId != null) {
        // Update the 'clickADtask' value to 16 (assuming it's an integer field)
        await FirebaseFirestore.instance.collection("user_data").doc(userId).update({
          'clickADtask': '16',
        });
        print('clickADtask updated successfully for user: $userId');
      } else {
        print('User not authenticated');
      }
    } catch (error) {
      print('Failed to update clickADtask: $error');
    }

    return Future.value(true);
  });
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((_) {
    Workmanager().initialize(callbackDispatcher, isInDebugMode: true); // Initialize Workmanager

    // Calculate initial delay until the next 4:00 PM
    DateTime now = DateTime.now();
    DateTime nextScheduledTime = DateTime(now.year, now.month, now.day, 16, 18, 0); // 4:00 PM
    if (now.isAfter(nextScheduledTime)) {
      nextScheduledTime = nextScheduledTime.add(Duration(days: 1)); // Schedule for next day if the time has passed today
    }
    int initialDelaySeconds = nextScheduledTime.difference(now).inSeconds;

    Workmanager().registerOneOffTask(
      "resetTask", // Unique name for the task
      "resetValue", // Task tag
      inputData: <String, dynamic>{},
      initialDelay: Duration(seconds: initialDelaySeconds), // Delay until next 4:00 PM
      constraints: Constraints(
        networkType: NetworkType.connected, // Constraint on network availability
      ),
    );

    var devices = ["7D97B18C12212FC4EA52D40A2213003E"];
    MobileAds.instance.initialize().then((_) {
      RequestConfiguration requestConfiguration = RequestConfiguration(testDeviceIds: devices);
      MobileAds.instance.updateRequestConfiguration(requestConfiguration);
      runApp(
        MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: 'login_page',
          routes: {'login_page': (context) => const Home()},
        ),
      );
    });
  });
}
