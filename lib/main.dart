import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:phone_otp_ui/phone.dart';
import 'package:phone_otp_ui/verify.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      initialRoute: 'phone',
      debugShowCheckedModeBanner: false,
      routes: {
        'phone': (context) => MyPhone(),
        'verify': (context) => MyVerify()
      },
    ),
  );
}
