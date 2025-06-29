import 'package:flutter/material.dart';
import 'package:parking/rerquest_accept.dart';
import 'package:parking/request_reject.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'config.dart';

class ParkingOwnerRequestsScreen extends StatefulWidget {
  @override
  _ParkingOwnerRequestsScreenState createState() =>
      _ParkingOwnerRequestsScreenState();
}

class _ParkingOwnerRequestsScreenState
    extends State<ParkingOwnerRequestsScreen> {
  List<dynamic> requests = [];

  Future<void> getRequests() async {
    try {
      final response = await http.get(Uri.parse(ownerRequestsEndpoint));
      if (response.statusCode == 200) {
        setState(() {
          requests = json.decode(response.body);
        });
      } else {
        print('Failed to load requests');
        // Handle error, show an error message to the user
      }
    } catch (error) {
      print('Error fetching requests: $error');
      // Handle network errors or other exceptions here
    }
  }

  @override
  void initState() {
    super.initState();
    getRequests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Parking Owner Requests'),
      ),
      body: requests.isEmpty
          ? Center(child: Text('No requests found.'))
          : ListView.builder(
        itemCount: requests.length,
        itemBuilder: (context, index) {
          String status = requests[index]['status'];
          bool hasActionButtons = status != 'accepted' && status != 'rejected';

          return ListTile(
            title: Text(requests[index]['parkingOwnerId']),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('User phn number: ${requests[index]['userId']}'),
                Text('Status: $status'),
              ],
            ),
            trailing: hasActionButtons
                ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black, // Set the button color to black
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AcceptRequestScreen(requestId: requests[index]['_id']),
                      ),
                    );
                  },
                  child: Text('Accept'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red, // Set the button color to red
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RejectRequestScreen(requestId: requests[index]['_id']),
                      ),
                    );
                  },
                  child: Text('Reject'),
                ),
              ],
            )
                : null,
          );
        },
      ),
    );
  }
}
