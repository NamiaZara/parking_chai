import 'package:flutter/material.dart';
import 'package:parking/dashboard.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/home.jpg'), fit: BoxFit.cover)
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack (
          children: [
            Container(
              padding: EdgeInsets.only(left: 35, top: 130),
              child: Text('পার্কিং \nচাই', style: TextStyle(
                  color: Colors.white,
                  fontSize: 54
              ),),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.45,
                    right: 35, left: 35),
                child: Column(
                  children: [
                    TextField(
                      style: TextStyle(color: Colors.white),
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          fillColor:Colors.black.withOpacity(0.8), // Add opacity to make it slightly transparent
                          filled: true,
                          hintText: 'Email',
                          hintStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          )
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextField(
                      style: TextStyle(color: Colors.white),
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          fillColor: Colors.black.withOpacity(0.8), // Add opacity to make it slightly transparent
                          filled: true,
                          hintText: 'Password',
                          hintStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          )
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Log in', style: TextStyle(
                            color: Colors.white,
                            fontSize: 27, fontWeight: FontWeight.w700
                        )),
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Color(0xff030303),
                          child: IconButton(onPressed:(){
                            Navigator.push(
                                context,MaterialPageRoute(builder: (contest) =>  DashboardPage()));
                          }, icon: Icon(Icons.arrow_forward)),

                        )
                      ],
                    ),
                    SizedBox(
                      height: 40,
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
