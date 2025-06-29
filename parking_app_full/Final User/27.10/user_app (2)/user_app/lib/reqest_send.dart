import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_app/userprovider.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
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
    if (Phn!= null) {
      final response = await http.post(
        Uri.parse(userRequestEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'userId': Phn,
          'parkingOwnerId': '648ef8e1ab542be80ff520a8',
        }),
      );

      if (response.statusCode == 201) {
        print('Request sent successfully');
        // Handle success, maybe show a success message to the user
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
