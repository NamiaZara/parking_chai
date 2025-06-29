import 'package:flutter/material.dart';
import 'package:user_app/User_login.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:user_app/After_login_dashboard.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'config.dart';
import 'dart:convert';

class create_user_account extends StatefulWidget {
  const create_user_account({Key? key}) : super(key: key);
  @override
  State<create_user_account> createState() => _create_user_account();
}

class _create_user_account extends State<create_user_account> {

  TextEditingController first_nameController = TextEditingController();  //to have user inputs
  TextEditingController last_nameController = TextEditingController();
  TextEditingController user_contact_numberController = TextEditingController();
  TextEditingController user_emailController = TextEditingController();
  TextEditingController user_passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isNotValidate = false;

  void registerUser() async{
    if( user_emailController.text.isNotEmpty && user_contact_numberController.text.isNotEmpty && user_passwordController.text.isNotEmpty && first_nameController.text.isNotEmpty && last_nameController.text.isNotEmpty  ){
      var regBody = {
        "first_name": first_nameController.text, //making object
        "last_name": last_nameController.text,
        "user_contact_number": user_contact_numberController.text,
        "user_email":user_emailController.text,
        "user_password":user_passwordController.text
      };
      var response = await http.post(Uri.parse(user_registration),
          headers: {"Content-Type":"application/json"},
          body: jsonEncode(regBody)
      );
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse['status']);
      if(jsonResponse['status']){
        _showLogoutConfirmationDialog(context);
        //Navigator.push(context, MaterialPageRoute(builder: (context)=>SignInPage()));
      }else{
        _showLogoutConfirmationDialog2(context);
        print("SomeThing Went Wrong");
      }
    }else{
      setState(() {
        _isNotValidate = true;
      });
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
              'assets/sign_up.svg', // Replace with your image asset path

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
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3,
                    right: 35, left: 35),
                child: Column(
                  children: [
                    SizedBox(
                      height: 180,
                    ),
                    TextField(
                      controller: first_nameController,
                      keyboardType: TextInputType.text,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          fillColor:Colors.black.withOpacity(0.8),
                          filled: true,
                          errorText: _isNotValidate ? "Enter Proper Info" : null,
                          hintText: 'First name',
                          hintStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          )
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: last_nameController,
                      keyboardType: TextInputType.text,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          fillColor:Colors.black.withOpacity(0.8),
                          filled: true,
                          errorText: _isNotValidate ? "Enter Proper Info" : null,
                          hintText: 'Last name',
                          hintStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          )
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: user_contact_numberController,
                      keyboardType: TextInputType.text,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          fillColor:Colors.black.withOpacity(0.8),
                          filled: true,
                          errorText: _isNotValidate ? "Enter Proper Info" : null,
                          hintText: 'Contact Number',
                          hintStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          )
                      ),
                    ),
                    SizedBox(height: 5),
                    TextField(
                      controller: user_emailController,
                      keyboardType: TextInputType.text,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          fillColor:Colors.black.withOpacity(0.8),
                          filled: true,
                          errorText: _isNotValidate ? "Enter Proper Info" : null,
                          hintText: 'Email',
                          hintStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          )
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: user_passwordController,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10),
                          fillColor:Colors.black.withOpacity(0.8),
                          filled: true,
                          errorText: _isNotValidate ? "Enter Proper Info" : null,
                          hintText: 'Password',
                          hintStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          )
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextButton(
                      child: Text('Sign in'),
                      onPressed: () {
                        registerUser();
                        // Navigator.push(
                        //context,MaterialPageRoute(builder: (contest) =>  parking_owner_dashboard()));
                      },
                      style: TextButton.styleFrom(
                        padding:const EdgeInsets.all(15),
                        foregroundColor: Colors.white,
                        backgroundColor:Colors.black.withOpacity(0.8), // Add opacity to make it slightly transparent
                        textStyle: const TextStyle(fontSize: 20),

                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => User_Login()),);
                            },
                            child: Text(
                              "Sign in",
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

void _showLogoutConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Your registration is done'),
        content: Text('Back to login page?'),
        actions: <Widget>[
          TextButton(
            child: Text('No',style: TextStyle(color: Colors.black)),
            onPressed: () {
              // Close the dialog
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Yes',style: TextStyle(color: Colors.black)),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>User_Login()));
            },
          ),
        ],
      );
    },
  );
}


void _showLogoutConfirmationDialog2(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Error'),
        content: Text('You already have an account'),
        actions: <Widget>[
          TextButton(
            child: Text('try again?',style: TextStyle(color: Colors.black)),
            onPressed: () {
              // Close the dialog
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('login?',style: TextStyle(color: Colors.black)),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>User_Login()));
            },
          ),
        ],
      );
    },
  );
}