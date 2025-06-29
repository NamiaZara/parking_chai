import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:parking/dashboard.dart';
import 'config.dart';
import 'dart:convert';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);
  @override
  State<Signin> createState() => _SignininState();
}
class _SignininState extends State<Signin> {

  TextEditingController nameController = TextEditingController();  //to have user inputs
  TextEditingController addressController = TextEditingController();
  TextEditingController contact_numberController = TextEditingController();
  TextEditingController Number_of_parking_spaceController = TextEditingController();
  TextEditingController ph_costController = TextEditingController();
  TextEditingController extra_costController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _isNotValidate = false;

  void registerUser() async{
    if(ph_costController.text.isNotEmpty && extra_costController.text.isNotEmpty && emailController.text.isNotEmpty && passwordController.text.isNotEmpty && nameController.text.isNotEmpty && addressController.text.isNotEmpty  && contact_numberController.text.isNotEmpty  && Number_of_parking_spaceController.text.isNotEmpty ){
      var regBody = {
        "name": nameController.text, //making object
        "address": addressController.text,
        "contact_number": contact_numberController.text,
        "parking_space_number": Number_of_parking_spaceController.text,
        "per_hour_cost":extra_costController.text,
        "extra_cost"  :ph_costController.text,
        "email":emailController.text,
        "password":passwordController.text
      };
      var response = await http.post(Uri.parse(registration),
          headers: {"Content-Type":"application/json"},
          body: jsonEncode(regBody)
      );
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse['status']);
      if(jsonResponse['status']){
        //Navigator.push(context, MaterialPageRoute(builder: (context)=>YourScreen()));
        _showLogoutConfirmationDialog(context);
      }else{
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
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/parking.jpg'), fit: BoxFit.cover)
      ),
      child: Scaffold(
        backgroundColor: customBackgroundColor,
        body: Stack (
            children: [
        Container(
        padding: EdgeInsets.only(left: 35, top: 90),
        child: Text('পার্কিং \nচাই', style: TextStyle(
            color: Colors.white,
            fontSize: 54
        ),),
      ),
      SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3,
              right: 35, left: 35),
          child: Column(
              children: [
          TextField(
            controller: nameController,
            keyboardType: TextInputType.text,
          decoration: InputDecoration(
              contentPadding:EdgeInsets.all(10),
              fillColor:Colors.black.withOpacity(0.8),
              filled: true,
              errorText: _isNotValidate ? "Enter Proper Info" : null,
              hintText: 'Name',
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
          controller: addressController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              contentPadding:EdgeInsets.all(10),
              fillColor:Colors.black.withOpacity(0.8),
              filled: true,
              errorText: _isNotValidate ? "Enter Proper Info" : null,
              hintText: 'Address',
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
          controller: contact_numberController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              contentPadding:EdgeInsets.all(10),
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
        SizedBox(
          height: 5,
        ),
        TextField(
          controller: Number_of_parking_spaceController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              contentPadding:EdgeInsets.all(10),
              fillColor:Colors.black.withOpacity(0.8),
              filled: true,
              errorText: _isNotValidate ? "Enter Proper Info" : null,
              hintText: 'Number of parking space',
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
                  controller: ph_costController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      contentPadding:EdgeInsets.all(10),
                      fillColor:Colors.black.withOpacity(0.8),
                      filled: true,
                      hintText: 'Per hour cost',
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
                  controller: extra_costController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      contentPadding:EdgeInsets.all(10),
                      fillColor:Colors.black.withOpacity(0.8),
                      filled: true,
                      hintText: 'Extra cost',
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
          controller: emailController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              contentPadding:EdgeInsets.all(10),
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
          controller: passwordController,
          keyboardType: TextInputType.text,
          obscureText: true,
          decoration: InputDecoration(
              contentPadding:EdgeInsets.all(10),
              fillColor:Colors.black.withOpacity(0.8),
              filled: true,
              hintText: 'Password',
              hintStyle: TextStyle(color: Colors.white),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
              )
          ),
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
         Text('Parking owner Registration', style: TextStyle(
              color:Colors.black,
              fontSize: 20 , fontWeight: FontWeight.w700
             // fontSize: 20, fontWeight: FontWeight.w700
          )),
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.black,
            child: IconButton(onPressed:(){
              registerUser();
            }, icon: Icon(Icons.arrow_forward)),
          )
          ],
        ),
          SizedBox(
            height: 30,
          ),
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
        title: Text('Parking owner registration is done'),
        content: Text('Back to home page?'),
        actions: <Widget>[
          TextButton(
            child: Text('No'),
            onPressed: () {
              // Close the dialog
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text('Yes'),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>DashboardPage()));
            },
          ),
        ],
      );
    },
  );
}

