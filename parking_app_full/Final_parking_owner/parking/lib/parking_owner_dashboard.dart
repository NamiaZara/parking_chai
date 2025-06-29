import 'package:parking/exit_data_print.dart';
import 'package:parking/home.dart';
import 'package:flutter/material.dart';
import 'package:parking/garage_owner_Login.dart';
import 'package:parking/Record entry time.dart';
import 'package:parking/record_exit_time.dart';
import 'package:parking/parking-history.dart';
import 'package:parking/requests.dart';
import 'parking_request.dart';

class parking_owner_dashboard extends StatelessWidget {

  final List<IconData> icons = [
    Icons.check_circle,
    Icons.history,
    Icons.edit,
  ];

  final List<String> labels = [
    'View requests',
    'Data History',
    'Daily Data Entry',
  ];

  @override
  Widget build(BuildContext context) {
    Color customBackgroundColor = Color(0xFFE7E4E4);
    Image.asset(
      'assets/home.jpg',
      fit: BoxFit.cover,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
    );
    return Scaffold(
      backgroundColor: customBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Parking Chai', style: TextStyle(
            color: Colors.white,
            fontSize: 25
        ),),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
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
            ),

            ListTile(
              leading: Icon(Icons.help_center),
              title: Text('Help'),
              onTap: () {
                // Handle drawer item tap for earning info
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

      body: Container(
        decoration: BoxDecoration(
          // Add your background image here
          image: DecorationImage(
            image: AssetImage('assets/parking1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child:GridView.builder(
          padding: EdgeInsets.all(20.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
          ),
          itemCount: icons.length,
          itemBuilder: (context, index) {
            return DashboardItem(
              icon: icons[index],
              label: labels[index],
              onTap: () {
                _handleDashboardItemTap(context, labels[index]);
              },
            );
          },
        ),
      ),
    );
  }
}
void _handleDashboardItemTap(BuildContext context, String label) {
  if (label == 'Daily Data Entry') {
    // Replace with your ProfileInfoPage constructor
    _showDailyDataEntryOptions(context);
  }
  else if (label == 'View requests') {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ParkingOwnerRequestsScreen()),
    );
   // _showPermissionOption(context);
    // Replace with your DailyDataEntryPage constructor

  }
  else if (label == 'Data History') {
    // Replace with your DailyDataEntryPage constructor
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Scene()),
    );
  }
  // Add similar conditions for other pages
}

void _showDailyDataEntryOptions(BuildContext context) async {
  final selectedOption = await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Daily Data Entry Options'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.access_time), // Entry Time icon
              title: Text('Record Entry Time'),
              onTap: () {
                Navigator.pop(context, 'Record Entry Time');
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app), // Exit Time icon
              title: Text('Record Exit Time'),
              onTap: () {
                Navigator.pop(context, 'Record Exit Time');
              },
            ),
          ],
        ),
      );
    },
  );

  // Handle navigation based on selectedOption
  if (selectedOption == 'Record Entry Time') {
    // Navigate to the page for recording entry time
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => InputPage()),
    );
  } else if (selectedOption == 'Record Exit Time') {
    // Navigate to the page for recording exit time
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => InputPage1()),
    );
  }
}

void _showPermissionOption(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => parkingrequest()));
} //sk
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
                  context,MaterialPageRoute(builder: (contest) =>  Home()));
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
class DashboardItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  DashboardItem({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: onTap,
      child: Card(
        elevation: 4.0,
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48.0, color: Colors.black),
            SizedBox(height: 10.0),
            Text(label, style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}


