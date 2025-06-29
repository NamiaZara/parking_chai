import 'package:flutter/material.dart';
import 'package:user_app/After_login_dashboard.dart';

class ProfilePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Color customBackgroundColor = Color(0xFFE7E4E4);

    return Scaffold(
      backgroundColor: customBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align content to the left
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Align content to the left
                children: [
                  Text(
                    'Profile Information',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Set text color to white
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: 150, // Set the width and height to make it square
                    height: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle, // Use a rectangle shape for a square avatar
                      color: Colors.black, // Set a background color for the square (you can change this color)
                    ),
                    child: Center(
                      child: Icon(
                        Icons.person, // Replace 'Icons.person' with the desired icon
                        size: 150, // Adjust the size of the icon to fit the container
                        color: Colors.black, // Set the color of the icon to black
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Jarin Tasnim',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            _buildInfoRow(Icons.email, 'Email: jarin@gmail.com'),
            _buildInfoRow(Icons.phone, 'Phone: 1234567890'),
            // _buildInfoRow(Icons.location_on, 'Address: 123 Rampura, Dhaka'),
            // _buildInfoRow(Icons.man_2, 'Gender: Female'),
            // _buildInfoRow(Icons.date_range, 'Date of Birth: 03.02.1999'),
            // _buildInfoRow(Icons.numbers_rounded, 'Car Number: Dhk-0128393'),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(Icons.home, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                      context,MaterialPageRoute(builder: (contest) => user_dashboard()));
                  },
                ),
                IconButton(
                  icon: Icon(Icons.map_sharp , color: Colors.white),
                  onPressed: () {
                    // Implement the action for the second icon here
                  },
                ),

                IconButton(
                  icon: Icon(Icons.person_3_sharp , color: Colors.white),
                  onPressed: () {
                    // Implement the action for the fourth icon here
                    Navigator.push(
                        context,MaterialPageRoute(builder: (contest) =>  ProfilePage()));
                  },
                ),
              ],
            ),
            SizedBox(height: 5), // Adjust spacing between icons and text
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Home', style: TextStyle(color: Colors.white)),
                Text('Map', style: TextStyle(color: Colors.white)),
                Text('Profile', style: TextStyle(color: Colors.white)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20), // Add left padding
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start, // Align content to the left
        children: [
          Icon(icon, color: Colors.black),
          SizedBox(width: 10),
          Text(text, style: TextStyle(fontSize: 16, color: Colors.black)),
        ],
      ),
    );
  }
}
