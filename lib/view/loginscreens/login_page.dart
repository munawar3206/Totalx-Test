import 'package:flutter/material.dart';
import 'package:totalxtask/service/phone_auth_service.dart';


class LoginPage extends StatelessWidget {
  LoginPage();

  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    hintStyle: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
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
                    submitPhoneNum(context, _phoneNumberController);
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
