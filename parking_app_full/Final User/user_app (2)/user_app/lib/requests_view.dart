import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:user_app/config.dart';

final String url = 'http://192.168.1.14:3000';

class ParkingOwnerRequestsScreen2 extends StatefulWidget {
  final dynamic userId;
  final String parkingOwnerId;

  ParkingOwnerRequestsScreen2({
    required this.userId,
    required this.parkingOwnerId,
  });

  @override
  _ParkingOwnerRequestsScreenState createState() =>
      _ParkingOwnerRequestsScreenState();
}

class _ParkingOwnerRequestsScreenState
    extends State<ParkingOwnerRequestsScreen2> {
  late String requests_view;

  @override
  void initState() {
    super.initState();
    requests_view = '$url/user/${widget.userId}';
    getRequests();
  }

  Future<void> getRequests() async {
    final response = await http.get(Uri.parse(requests_view));

    if (response.statusCode == 200) {
      setState(() {
        requests = json.decode(response.body);
      });
    } else {
      print('Failed to load requests');
      // Handle error, show an error message to the user
    }
  }

  List<dynamic> requests = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('All Requests'),
      ),
      body: ListView.builder(
        itemCount: requests.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Request ID: ${requests[index]['parkingOwnerId']}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Status: ${requests[index]['status']}'),
                //Text('Status: $status'),
              ],
            ),
            // Display other request details as needed
          );
        },
      ),
    );
  }
}
