import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:totalxtask/view/otp.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController _phoneNumberController = TextEditingController();

  Future<void> _submitPhoneNum(BuildContext context) async {
    String phoneNumber = _phoneNumberController.text.trim();
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
              ));
        },
        codeAutoRetrievalTimeout: (String verificationId) {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Center(
                  child: Image.asset(
                    "assets/log-removebg-preview.png",
                    height: 150,
                  ),
                ),
              ),
              const Text(
                "Enter the Phonenumber",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 22),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _phoneNumberController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: "Enter Phone Number *",
                    hintStyle:
                        const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "By Continuing, I agree to TotalX's ",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    TextSpan(
                      text: "Terms and Conditions ",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.w600),
                    ),
                    TextSpan(
                      text: "& ",
                    ),
                    TextSpan(
                      text: "Privacy Policy",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(25)),
                child: MaterialButton(
                  onPressed: () {
                    _submitPhoneNum(context);
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => OtpScreen(verificationid:verificationid ,),
                    //     ));
                  },
                  child: const Text(
                    "Get OTP",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
