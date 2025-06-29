// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:parking/home.dart';
// import 'package:parking/parking-history.dart';
//
//
// /*class _ProfilePageState extends State<ProfilePage> {
//   List<dynamic> profiles = [];
//
//   @override
//   void initState() {
//     super.initState();
//     fetchProfiles();
//   }
//
//   Future<void> fetchProfiles() async {
//     final response = await http.get(Uri.parse('http://your_backend_url/api/profile'));
//     if (response.statusCode == 200) {
//       setState(() {
//         profiles = json.decode(response.body);
//       });
//     }
//   }*/
//
// class ProfilePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     Color customBackgroundColor = Color(0xFFE7E4E4);
//
//     return Scaffold(
//       backgroundColor: customBackgroundColor,
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         title: Text(
//           'Parking Chai',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 25,
//           ),
//         ),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               padding: EdgeInsets.only(top: 0),
//               child: Text('Profile Information', style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                   fontSize: 35
//               ),),
//             ),
//             Padding(
//               padding: EdgeInsets.all(20),
//               child: Column(
//                 children: [
//                   CircleAvatar(
//                     radius: 70,
//                     //backgroundImage: NetworkImage(profile['profile_picture']),
//                     backgroundImage: AssetImage('assets/dp.png'),
//                   ),
//                   SizedBox(height: 20),
//                   Text(
//                     //profile['name'],
//                     'MR. Stranger',
//                     style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 30),
//             _buildInfoRow(Icons.email, 'abc@example.com'),
//             _buildInfoRow(Icons.phone, '1234567890'),
//             _buildInfoRow(Icons.location_on, '123 Main Street, City'),
//
//            /* _buildInfoRow(Icons.email, profile['email']),
//             _buildInfoRow(Icons.phone, profile['phone']),
//             _buildInfoRow(Icons.location_on, profile['location']),
//             */
//           ],
//         ),
//       ),
//
//       // Bottom app bar
//       bottomNavigationBar: BottomAppBar(
//         color: Colors.black,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 IconButton(
//                   icon: Icon(Icons.home, color: Colors.white),
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => Home()),
//                     );
//                     // Implement the action for the first icon here
//                   },
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.verified_user, color: Colors.white),
//                   onPressed: () {
//                     // Implement the action for the first icon here
//                   },
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.history, color: Colors.white),
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => Scene()),
//                     );
//                     // Implement the action for the second icon here
//                   },
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.people, color: Colors.white),
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => ProfilePage()),
//                     );
//                     // Implement the action for the third icon here
//                   },
//                 ),
//               ],
//             ),
//             SizedBox(height: 5), // Adjust spacing between icons and names
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 Center(child: Text(' Home', style: TextStyle(color: Colors.white))),
//                 Center(child: Text('Permission', style: TextStyle(color: Colors.white))),
//                 Center(child: Text('History', style: TextStyle(color: Colors.white))),
//                 Center(child: Text('Profile', style: TextStyle(color: Colors.white))),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildInfoRow(IconData icon, String text) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(icon, color: Colors.black),
//           SizedBox(width: 10),
//           Text(text, style: TextStyle(fontSize: 16, color: Colors.black87)),
//         ],
//       ),
//     );
//   }
// }
