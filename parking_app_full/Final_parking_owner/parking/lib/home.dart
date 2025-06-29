import 'package:flutter/material.dart';
import 'package:parking/login.dart';
import 'package:parking/garage_owner_login.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  @override
  Widget build(BuildContext context) {
    Color customBackgroundColor = Color(0xFFE7E4E4);
    return Container(
      //decoration:
      //BoxDecoration(
          //image: DecorationImage(image: AssetImage('assets/16.png'), fit: BoxFit.cover)
      //),
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
              padding: EdgeInsets.only(left: 40, top: 170),
              child: Text('পার্কিং \nচাই', style: TextStyle(
                  color: Colors.white,
                  fontSize: 54
              ),),
            ),
            SingleChildScrollView(

              child: Container(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.5,
                    right: 35, left: 35),
                child: Center(
                  child: Column(
                    children: [
                      TextButton(
                        child: Text('Parking Owner'),
                        onPressed: () {
                          Navigator.push(
                              context,MaterialPageRoute(builder: (contest) =>  garage_owner_Login()));
                        },
                        style: TextButton.styleFrom(

                          padding:const EdgeInsets.all(15),
                          foregroundColor: Colors.white,
                          backgroundColor:Colors.black,
                          textStyle: const TextStyle(fontSize: 20),

                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),

                      TextButton(
                        child: Text('Admin'),
                        onPressed: () {
                          Navigator.push(
                              context,MaterialPageRoute(builder: (contest) =>  MyLogin()));
                        },
                        style: TextButton.styleFrom(
                          padding:const EdgeInsets.all(15),
                          foregroundColor: Colors.white,
                          backgroundColor:Colors.black,
                          textStyle: const TextStyle(fontSize: 20),

                        ),
                      ),
                    ],
                  ),
                )

              ),
            ),
          ],
        ),
      ),
    );
  }
}
