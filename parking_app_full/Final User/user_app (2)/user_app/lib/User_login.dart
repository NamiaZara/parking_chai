import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_app/userprovider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_app/want_phn_number.dart';
import 'package:user_app/reqest_send.dart';
import 'package:user_app/recovery_mail.dart';
import 'package:user_app/create_account_user.dart';
import 'package:user_app/user_login_confirmation.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'config.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class User_Login extends StatefulWidget {
  const User_Login({Key? key}) : super(key: key);

  @override
  State<User_Login> createState() => _User_Login();
}

class _User_Login extends State<User_Login> {
  TextEditingController user_emailController = TextEditingController();
  TextEditingController user_passwordController = TextEditingController();
  bool _isNotValidate = false;
  late SharedPreferences prefs;
  void initState() {
    // TODO: implement initState
    super.initState();
    initSharedPref();
  }
  void initSharedPref() async{
    prefs = await SharedPreferences.getInstance();
  }

  void app_user_login() async{
    if(user_emailController.text.isNotEmpty && user_passwordController.text.isNotEmpty){
      var reqBody = {
        "user_email":user_emailController.text,
        "user_password":user_passwordController.text
      };
      var response = await http.post(Uri.parse(user_login),
          headers: {"Content-Type":"application/json"},
          body: jsonEncode(reqBody)
      );
      var jsonResponse = jsonDecode(response.body);
      if(jsonResponse['status']){
        var myToken = jsonResponse['token'];
        prefs.setString('token', myToken);

        // // Set the user ID after successful login
        // var userProvider = Provider.of<UserProvider>(context, listen: false);
        // userProvider.setUserId(jsonResponse['userId']);

        Navigator.push(context, MaterialPageRoute(builder: (context)=>Dashboard_garage_owner(token: myToken)));
      }else{
        print('Something went wrong');
      }
    }
  }
  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Loged in',style: TextStyle(
            color: Colors.black,
          ),),
          content: Text('Welcome to Parking Chai',style: TextStyle(
            color: Colors.black,
          ),),
          actions: [
            TextButton(
              onPressed: () {
                //Navigator.of(context).pop();
                app_user_login();
              },
              child: Text('Profile',style: TextStyle(
                color: Colors.black,
              ),),
            ),
            TextButton(
              onPressed: () {
                app_user_login2();
                // Navigator.push(
                //     context,MaterialPageRoute(builder: (contest) =>  User_Login()));
                // //(context); // Call your logout function here
              },
              child: Text('Send request',style: TextStyle(
                color: Colors.black,
              ),),
            ),
          ],
        );
      },
    );
  }
  void app_user_login2() async{
    if(user_emailController.text.isNotEmpty && user_passwordController.text.isNotEmpty){
      var reqBody = {
        "user_email":user_emailController.text,
        "user_password":user_passwordController.text
      };
      var response = await http.post(Uri.parse(user_login),
          headers: {"Content-Type":"application/json"},
          body: jsonEncode(reqBody)
      );
      var jsonResponse = jsonDecode(response.body);
      if(jsonResponse['status']){
        var myToken = jsonResponse['token'];
        prefs.setString('token', myToken);

        // // Set the user ID after successful login
        // var userProvider = Provider.of<UserProvider>(context, listen: false);
        // userProvider.setUserId(jsonResponse['userId']);

        Navigator.push(context, MaterialPageRoute(builder: (context)=>UserRequestScreen(token: myToken)));
      }else{
        print('Something went wrong');
      }
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
            SvgPicture.asset(
              'assets/mobile_login.svg', // Replace with your image asset path

            ),
            Container(
                padding: EdgeInsets.only(left: 35, top: 90),
                child: Text('পার্কিং \nচাই', style: TextStyle(
                    color: Colors.black,
                    fontSize: 54
                ),),

            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.39,
                    right: 35, left: 35),
                child: Column(
                  children: [
                    SizedBox(
                      height: 130,
                    ),
                    TextField(
                      controller: user_emailController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          fillColor:Colors.black.withOpacity(0.8), // Add opacity to make it slightly transparent
                          filled: true,
                          hintText: 'Email',
                          hintStyle: TextStyle(color: Colors.white),
                          errorText: _isNotValidate ? "Enter Proper Info" : null,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          )
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    TextField(
                      obscureText: true,
                      controller: user_passwordController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          fillColor: Colors.black.withOpacity(0.8), // Add opacity to make it slightly transparent
                          filled: true,
                          hintText: 'Password',
                          hintStyle: TextStyle(color: Colors.white),
                          errorText: _isNotValidate ? "Enter Proper Info" : null,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          )
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ResetPasswordScreen()),);
                            },
                            child: Text(
                              'Forget Your Password',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextButton(
                      child: Text('log in'),
                      onPressed: () {

                          _showLogoutConfirmationDialog(context);

                       // Navigator.push(
                       //      context,MaterialPageRoute(builder: (contest) =>  user_dashboard()));
                      },
                      style: TextButton.styleFrom(
                        padding:const EdgeInsets.all(15),
                        foregroundColor: Colors.white,
                        backgroundColor:Colors.black.withOpacity(0.8), // Add opacity to make it slightly transparent
                        textStyle: const TextStyle(fontSize: 20),

                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Do not have an account? ",
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                               context,
                                MaterialPageRoute(builder: (context) => create_user_account()),);
                            },
                            child: Text(
                              "Create an account",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

