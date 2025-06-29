import 'package:flutter/material.dart';
import 'package:user_app/User_login.dart';
import 'package:user_app/phn_authe.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Location_On extends StatelessWidget {
  const Location_On({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Color customBackgroundColor = Color(0xFFE7E4E4);
    return Scaffold(
      backgroundColor: customBackgroundColor,
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/location.svg', // Replace with your actual image path
                width: 200,
                height: 200,
              ),
              SizedBox(height: 40),
              Text(
                'Find parking spaces near you!',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                'Allow location access to find available parking spaces nearby.',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30),
              TextButton(
                child: Text('Share my currect location'),
                onPressed: () {
                  Navigator.push(
                      context,MaterialPageRoute(builder: (contest) =>  User_Login()));
                },
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.all(15),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.black,
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 20),
              Container(
                //padding: EdgeInsets.all(10), // Adjust padding to control the size
                width: 220, // Adjust the width as desired
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextButton(
                  onPressed: () {
                      Navigator.push(
                      context,MaterialPageRoute(builder: (contest) =>  AnimatedPage()));
                    // Add your onPressed logic here
                  },
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(10), // Adjust padding inside the button
                    foregroundColor: Colors.black,
                    textStyle: const TextStyle(fontSize: 18),
                  ),

                  child: Text('Enter manual address'),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}