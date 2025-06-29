import 'package:flutter/material.dart';
import 'package:user_app/User_login.dart';
import 'package:user_app/create_account_user.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'config.dart';

class ResetPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  Color customBackgroundColor = Color(0xFFE7E4E4);

  Future<void> resetPassword(BuildContext context, String user_email) async {
    final response = await http.post(Uri.parse(userresetpass),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'user_email': user_email,
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
                    MaterialPageRoute(builder: (context) => User_Login()),
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
                    MaterialPageRoute(builder: (context) => create_user_account()),
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

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Reset Password',
          //style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: customBackgroundColor,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
                  SizedBox(height: 10),
        Row(
          //alignment: Alignment.centerLeft,// Add spacing between text and image
                  children:[
                    Text(
                    'পার্কিং \nচাই',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 50,
                    ),
                  ),
                    SizedBox(width: 10), // Add some spacing between text and SVG
                    Container(
                      height: 200, // Set the height of the SVG image container
                      width: 200,  // Set the width of the SVG image container
                      child: SvgPicture.asset(
                        'assets/recovery_mail.svg', // Replace with your image asset path
                      ),
                    ),
                  ]
        ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String email = emailController.text.trim();
                resetPassword(context, email);
              },
              style: ElevatedButton.styleFrom(primary: Colors.black),
              child: Text(
                'Reset Password',
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => create_user_account()),
                );
              },
              child: Text(
                "Don't Have an Account? Sign Up",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold, // Make the text bold
                ),
              ),
            ),
                       TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => User_Login()),
                            );
                          },
                          child: Text(
                            "Already Have an Account? Sign In",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold, // Make the text bold
                            ),
                          ),
                        ),
          ],
        ),
      ),
    );
  }
}


