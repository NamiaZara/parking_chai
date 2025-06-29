import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';
import 'dart:convert';
import 'config.dart';

class ParkingOwnerRequestsScreen extends StatefulWidget {
  final String token;

  const ParkingOwnerRequestsScreen({required this.token, Key? key}) : super(key: key);

  @override
  _ParkingOwnerRequestsScreenState createState() =>
      _ParkingOwnerRequestsScreenState();
}

class _ParkingOwnerRequestsScreenState extends State<ParkingOwnerRequestsScreen> {
   List<dynamic> requests = [];
  late String parkingOwnerId;
  //late var email;

  @override
  void initState() {
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
    //parkingOwnerId = jwtDecodedToken['parkingOwnerId'];
    parkingOwnerId = jwtDecodedToken['email'];
    getRequests();
  }

  Future<void> getRequests() async {
    final response = await http.get(Uri.parse('$ownerRequestsEndpoint$parkingOwnerId'));

    if (response.statusCode == 200) {
      setState(() {
        return json.decode(response.body);
      });
    } else {
      print('Failed to load requests');
      // Handle error, show an error message to the user
    }
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       backgroundColor: Colors.black,
  //       title: Text('Parking Owner List'),
  //     ),
  //     body: FutureBuilder(
  //       future: getRequests(),
  //       builder: (context, snapshot) {
  //         if (snapshot.connectionState == ConnectionState.waiting) {
  //           return Center(child: CircularProgressIndicator());
  //         } else if (snapshot.hasError) {
  //           return Center(child: Text('Error: ${snapshot.error}'));
  //         } else if (!snapshot.hasData || (snapshot.data as List).isEmpty) {
  //           return Center(child: Text('No users found.'));
  //         } else {
  //           List<dynamic> users = snapshot.data as List<dynamic>;
  //           return ListView.builder(
  //             itemCount: users.length,
  //             itemBuilder: (context, index) {
  //               return ListTile(
  //                 title: Text(users[index]['parkingOwnerId']),
  //                 subtitle: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text('Email: ${users[index]['userId']}'),
  //                     Text('Address: ${users[index]['status']}'),
  //                     // Text('Number: ${users[index]['contact_number']}'),
  //                     // Text('Space: ${users[index]['parking_space_number']}'),
  //                     // Text('Per_hr_cost: ${users[index]['per_hour_cost']}'),
  //                     // Text('extra_cost: ${users[index]['extra_cost']}'),
  //                     // Add more Text widgets for additional information if needed
  //                   ],
  //                 ),
  //               );
  //             },
  //           );
  //         }
  //       },
  //     ),
  //   );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pending Requests'),
      ),
      body: ListView.builder(
        itemCount: requests.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Request ID: ${requests[index]['userId']}'),
            // Display other request details as needed
          );
        },
      ),
    );
  }
}
