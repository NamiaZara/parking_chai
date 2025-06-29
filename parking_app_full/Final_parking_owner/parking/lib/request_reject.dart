import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
final url = 'http://192.168.1.14:3000';

class RejectRequestScreen extends StatelessWidget {
  final String requestId;
  final String rejectRequestEndpoint;

  RejectRequestScreen({required this.requestId})
      : rejectRequestEndpoint = '$url/owner/requests/reject/$requestId';

  Future<void> acceptRequest() async {
    try {
      final response = await http.post(Uri.parse(rejectRequestEndpoint),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'requestId': requestId,
        }),
      );

      if (response.statusCode == 200) {
        print('Request $requestId accepted successfully');
      } else {
        print('Failed to accept request');
        print('Response Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');
        // Handle error, show an error message to the user
      }
    } catch (error) {
      print('Error accepting request: $error');
      // Handle network or other errors here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Accept Request'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Are you sure you want to accept the request?',
              style: TextStyle(
                fontSize: 28, // Set the font size to your desired value
                fontWeight: FontWeight.bold, // Make the text bold
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 20), // Add some spacing between text and buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black, // Set the button color to black
                  ),
                  onPressed: () {
                    // Call your acceptRequest function here
                    acceptRequest();
                    Navigator.of(context)
                        .pop();
                  },
                  child: Text('Yes'),
                ),
                SizedBox(width: 20), // Add spacing between buttons
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black, // Set the button color to black
                  ),
                  onPressed: () {
                    // Handle action when user presses 'No', if needed
                    Navigator.of(context)
                        .pop(); // Close the screen when 'No' is pressed
                  },
                  child: Text('No'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
