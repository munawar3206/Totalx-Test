import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:totalxtask/view/loginscreens/otp.dart';


Future<void> submitPhoneNum(BuildContext context, TextEditingController phoneNumberController) async {
  String phoneNumber = phoneNumberController.text.trim();

  if (!phoneNumber.startsWith("+91")) {
    phoneNumber = "+91" + phoneNumber;
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  await auth.verifyPhoneNumber(
    phoneNumber: phoneNumber,
    verificationCompleted: (PhoneAuthCredential credential) async {},
    verificationFailed: (FirebaseAuthException e) {
      print(e.message.toString());
    },
    codeSent: (String verificationId, forceResendingToken) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OtpScreen(
            verificationid: verificationId,
            phoneNumberController: phoneNumber,
          ),
        ),
      );
    },
    codeAutoRetrievalTimeout: (String verificationId) {},
  );
}
