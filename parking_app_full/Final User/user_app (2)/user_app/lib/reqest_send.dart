import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:user_app/requests_view.dart';
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
                  child: Text('Yes'),
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
                  child: Text('No'),
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
      body: Center(
        child: ElevatedButton(
          onPressed: () => sendRequest(context),
          child: Text('Send Request'),
        ),
      ),
    );
  }
}

