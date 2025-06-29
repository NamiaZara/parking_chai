import 'package:flutter/material.dart';
import 'package:parking/forgetpass.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dashboard_3.dart';
import 'parking_owner_dashboard.dart';
import 'package:http/http.dart' as http;
import 'package:parking/parkingowner_request_view.dart';
import 'package:parking/rerquest_accept.dart';
import 'config.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class garage_owner_Login extends StatefulWidget {
  const garage_owner_Login({Key? key}) : super(key: key);

  @override
  State<garage_owner_Login> createState() => _garage_owner_LoginState();
}

class _garage_owner_LoginState extends State<garage_owner_Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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

  void owner_login() async{
    if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty){
      var reqBody = {
        "email":emailController.text,
        "password":passwordController.text
      };
      var response = await http.post(Uri.parse(garage_owner_login),
          headers: {"Content-Type":"application/json"},
          body: jsonEncode(reqBody)
      );
      var jsonResponse = jsonDecode(response.body);
      if(jsonResponse['status']){
        var myToken = jsonResponse['token'];
        prefs.setString('token', myToken);
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
                owner_login();;
              },
              child: Text('Profile',style: TextStyle(
                color: Colors.black,
              ),),
            ),
            TextButton(
              onPressed: () {
                owner_login2();
                // Navigator.push(
                //     context,MaterialPageRoute(builder: (contest) =>  User_Login()));
                // //(context); // Call your logout function here
              },
              child: Text('View requests',style: TextStyle(
                color: Colors.black,
              ),),
            ),
          ],
        );
      },
    );
  }
  void owner_login2() async{
    if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty){
      var reqBody = {
        "email":emailController.text,
        "password":passwordController.text
      };
      var response = await http.post(Uri.parse(garage_owner_login),
          headers: {"Content-Type":"application/json"},
          body: jsonEncode(reqBody)
      );
      var jsonResponse = jsonDecode(response.body);
      if(jsonResponse['status']){
        var myToken = jsonResponse['token'];
        prefs.setString('token', myToken);
       // Navigator.push(context, MaterialPageRoute(builder: (context)=>AcceptRequestScreen(token: myToken)));
      }else{
        print('Something went wrong');
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    Color customBackgroundColor = Color(0xFFE7E4E4);
    return Container(
      //decoration: BoxDecoration(
         // image: DecorationImage(image: AssetImage('assets/16.png'), fit: BoxFit.cover)
     // ),
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
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.39,
                    right: 35, left: 35),
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(onPressed: (){

                        },
                            child: Text('Parking Owner Log in', style: TextStyle(
                              fontSize: 25, color: Colors.white,
                            ),
                            )
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextField(
                      style: TextStyle(color: Colors.white),
                      controller: emailController,
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
                      style: TextStyle(color: Colors.white),
                      obscureText: true,
                      controller: passwordController,
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

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(onPressed: (){
                          Navigator.push(
                              context,MaterialPageRoute(builder: (contest) =>  ForgetPass()));
                        }, child: Text('Forget Password', style: TextStyle( decoration: TextDecoration.underline,
                          fontSize: 20, color: Colors.white,
                        ),
                        )
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextButton(
                      child: Text('Sign in'),
                      onPressed: () {
                        // Navigator.push(
                        //     context,MaterialPageRoute(builder: (contest) =>  parking_owner_dashboard()));

                        _showLogoutConfirmationDialog(context);
                      },
                      style: TextButton.styleFrom(
                        padding:const EdgeInsets.all(15),
                        foregroundColor: Colors.white,
                        backgroundColor:Colors.black.withOpacity(0.8), // Add opacity to make it slightly transparent
                        textStyle: const TextStyle(fontSize: 20),

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
