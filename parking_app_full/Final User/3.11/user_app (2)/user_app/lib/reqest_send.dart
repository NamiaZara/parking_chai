import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:user_app/requests_view.dart';
import 'package:user_app/saves_address.dart';
import 'package:user_app/User_login.dart';
import 'package:user_app/user_permissions.dart';
import 'dart:convert';
import 'config.dart';

class UserRequestScreen extends StatefulWidget {
  final String token;

  const UserRequestScreen({required this.token, Key? key}) : super(key: key);

  @override
  _UserRequestScreenState createState() => _UserRequestScreenState();
}

class _UserRequestScreenState extends State<UserRequestScreen> {
  late var Phn;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);

    // Use null-aware operator to handle null case
    Phn = jwtDecodedToken['Phn'] ;
  }

  Future<void> sendRequest(BuildContext context) async {
    if (Phn != null) {
      final response = await http.post(
        Uri.parse(userRequestEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'userId': Phn,
          'parkingOwnerId': 'vv@gmail.com',
        }),
      );

      if (response.statusCode == 201) {
        print('Request sent successfully');
        // Show a popup dialog to ask the user if they want to view the list
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Request Sent'),
              content: Text('Request is sent. Do you want to view the list of requests?'),
              actions: <Widget>[
                TextButton(
                  child: Text('Yes',style: TextStyle(
                    color: Colors.black,
                  ),),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ParkingOwnerRequestsScreen2(
                          userId: Phn,
                          parkingOwnerId: 'vv@gmail.com',
                        ),
                      ),
                    );

                  },
                ),
                TextButton(
                  child: Text('No',style: TextStyle(
                    color: Colors.black,
                  ),),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      } else {
        print('Failed to send request');
        // Handle error, show an error message to the user
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Send Request'),
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
                  backgroundImage: AssetImage('assets/dp.png'),
                  radius: 30,
                  backgroundColor: customBackgroundColor,

                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),

            ListTile(
              leading: Icon(Icons.help_center),
              title: Text('Help'),
              onTap: () {
                // Handle drawer item tap for earning info
              },
            ),
            ListTile(
              leading: Icon(Icons.check_circle),
              title: Text('Permissions'),
              onTap: () {
                Navigator.push(
                    context,MaterialPageRoute(builder: (contest) =>  PermissionPage()));
              },
            ),
            ListTile(
              leading: Icon(Icons.help_center),
              title: Text('Policies'),
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
            ListTile(
              title: Text('Log Out'),
              onTap: () {
                _showLogoutConfirmationDialog(context);
              },
            ),

          ],
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => sendRequest(context),
          child: Text('Send Request'),
          style: ElevatedButton.styleFrom(
            primary: Colors.black, // Set the background color to black
          ),
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
        title: Text('Log Out',style: TextStyle(
          color: Colors.black,
        ),),
        content: Text('Are you sure you want to log out?',style: TextStyle(
          color: Colors.black,
        ),),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel',style: TextStyle(
              color: Colors.black,
            ),),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                  context,MaterialPageRoute(builder: (contest) =>  User_Login()));
              //(context); // Call your logout function here
            },
            child: Text('Log Out',style: TextStyle(
              color: Colors.black,
            ),),
          ),
        ],
      );
    },
  );
}

