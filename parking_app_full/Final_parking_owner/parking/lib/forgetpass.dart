import 'package:flutter/material.dart';
import 'package:parking/garage_owner_Login.dart';
import 'package:parking/sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'config.dart';

class ForgetPass extends StatefulWidget {
  //const ForgetPass({Key? key}) : super(key: key);

  @override
  State<ForgetPass> createState() => _ForgetPass();
}

class _ForgetPass extends State<ForgetPass> {
  final TextEditingController emailController = TextEditingController();
  Color customBackgroundColor = Color(0xFFE7E4E4);

  Future<void> resetPassword(BuildContext context, String email) async {
    final response = await http.post(Uri.parse(ownerresetpass),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
      }),
    );

    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Password Reset Email Sent'),
            content: Text('Your new password has been sent to your email. Would you like to log in?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('No',style: TextStyle(color: Colors.black),),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  // Navigate to the login screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => garage_owner_Login()),
                  );
                },
                child: Text('Yes',style: TextStyle(color: Colors.black),),
              ),
              TextButton(
                onPressed: () {
                  String email = emailController.text.trim();
                  resetPassword(context, email);
                },
                child: Text('Resend',style: TextStyle(color: Colors.black),),
              ),
            ],
          );
        },
      );
    } else if (response.statusCode == 404) {
      //print('Email not found');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Email not found'),
            content: Text('Want to create a new account?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('No',style: TextStyle(color: Colors.black),),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Signin()),
                  );
                },
                child: Text('Yes',style: TextStyle(color: Colors.black),),
              ),
            ],
          );
        },
      );
    } else {
      print('Failed to reset password');
      // Handle other errors, e.g., show an error message to the user
    }
  }
  @override
  Widget build(BuildContext context) {
    Color customBackgroundColor = Color(0xFFE7E4E4);
    return Container(
      child: Scaffold(
        backgroundColor: customBackgroundColor,
        body: Stack (
          children: [
            Image.asset(
              'assets/home.jpg', // Replace with your image asset path
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),

            Container(
              padding: EdgeInsets.only(left: 35, top: 170),
              child: Text('পার্কিং \nচাই', style: TextStyle(
                  color: Colors.white,
                  fontSize: 54
              ),),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.4,
                    right: 35, left: 35),
                child: Column(
                  children: [
                    SizedBox(
                      height: 70,
                    ),
                    TextField(
                      style: TextStyle(color: Colors.white),
                      controller: emailController,
                      decoration: InputDecoration(
                          fillColor: Colors.black.withOpacity(0.8), // Add opacity to make it slightly transparent
                          filled: true,
                          hintText: 'Enter Your Email',
                          hintStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          )

                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                         TextButton(
                          child: Text('Reset password'),
                           onPressed: () {

                             String email = emailController.text.trim();
                             resetPassword(context, email);
                           },
                          style: TextButton.styleFrom(
                            padding:const EdgeInsets.all(15),
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.black.withOpacity(0.8), // Add opacity to make it slightly transparent
                            textStyle: const TextStyle(fontSize: 20),

                          ),
                        )
                      ],
                    ),
                    ),
            )
                  ],
                ),
              ),
            );
  }
}
