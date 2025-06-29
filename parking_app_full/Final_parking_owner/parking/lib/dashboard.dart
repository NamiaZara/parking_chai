import 'package:flutter/material.dart';
import 'package:parking/sign_in.dart';
import 'package:parking/parking_owner_data_show.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color customBackgroundColor = Color(0xFFE7E4E4);
    Image.asset(
      'assets/parking.jpg',
      fit: BoxFit.cover,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
    );
    return Scaffold(
      backgroundColor: customBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              // Handle profile icon tap
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/profile_icon.png'),
                  radius: 30,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person_add),
              title: Text('Register Garage Owner'),
              onTap: () {
                Navigator.push(
                    context,MaterialPageRoute(builder: (contest) =>  Signin()));
                // Handle drawer item tap for register garage owner
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Garage Owner Info'),
              onTap: () {
                Navigator.push(
                    context,MaterialPageRoute(builder: (contest) =>  UserListScreen())); // Handle drawer item tap for garage owner info
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('User Info'),
              onTap: () {
                // Handle drawer item tap for user info
              },
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text('Parking History'),
              onTap: () {
                // Handle drawer item tap for parking history
              },
            ),
            ListTile(
              leading: Icon(Icons.monetization_on),
              title: Text('Earning Info'),
              onTap: () {
                // Handle drawer item tap for earning info
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                // Handle drawer item tap for settings
              },
            ),
          ],
        ),
      ),
      body: Container(
        child: Center(
          child: Text('Welcome to পার্কিং চাই', style: TextStyle(
              color: Colors.black,
              fontSize: 30
          ),),
        ),
      ),
    );
  }
}
