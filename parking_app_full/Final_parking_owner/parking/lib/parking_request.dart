import 'package:flutter/material.dart';
import 'parking_owner_dashboard.dart';

class parkingrequest extends StatefulWidget {
  const parkingrequest({super.key});

  @override
  State<parkingrequest> createState() => _parkingrequestState();
}

class _parkingrequestState extends State<parkingrequest> {
  @override
  Widget build(BuildContext context) {
    Color customBackgroundColor = Color(0xFF000000);
    return Scaffold(
      backgroundColor: customBackgroundColor,
      appBar: appBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(
                'Parking Request',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Quicksand'),
              ),
            ),
            totalRequestContainer(),
            viewParkingRequest(),
            gridView(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      title: FlutterLogo(
        size: 25,
      ),
      elevation: 0,
      centerTitle: true,
      backgroundColor: Colors.black,
    );
  }

  Widget totalRequestContainer() {
    return Container(
      margin: EdgeInsets.fromLTRB(15, 20, 15, 0),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black)]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total Request',
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Quicksand'),
              ),
              Text(
                '206', //reques
                style: TextStyle(
                    fontSize: 40,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Quicksand'),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Color(0xFF000000).withOpacity(0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: Text(
                'View Details',
                style: TextStyle(
                    color: Color(0xff000000),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Quicksand'),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget viewParkingRequest() {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 20, 15, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Parking Request',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: 'Quicksand',
              fontSize: 12,
            ),
          ),

        ],
      ),
    );
  }

  Widget gridView() {
    return GridView.count(
      crossAxisCount: 2,
      padding: EdgeInsets.fromLTRB(10, 0, 10, 8),
      primary: false,
      crossAxisSpacing: 4,
      mainAxisSpacing: 4,
      shrinkWrap: true,
      children: [
        gridViewItem(name: 'John Doe', description: 'Govt employee', status: 'Incoming', image: 'assets/14.jpg'),
        gridViewItem(name: 'Rive ', description: 'Freelancer', status: 'Incoming', image: 'assets/p2.jpg'),
        gridViewItem(name: 'Jane ', description: 'Businessman', status: 'Incoming', image: 'assets/15.jpg'),
        gridViewItem(name: 'Robert ', description: 'Student', status: 'Incoming', image: 'assets/dp.jpg'),
        gridViewItem(name: 'Lory Doe', description: 'Clark', status: 'Incoming', image: 'assets/parking.jpg'),
        gridViewItem(name: 'John clark', description: 'Govt employee', status: 'Incoming', image: 'assets/parking1.jpg')
      ],
    );
  }

  Widget gridViewItem(
      {required String name,
        required String description,
        required String status,
        required String image}) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      elevation: 4,
      shadowColor: Colors.black,
      child: Container(
        padding: EdgeInsets.only(top: 13),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color(0xff000000),
                      image: DecorationImage(
                          image: AssetImage(image), fit: BoxFit.cover)),
                ),
                Positioned(
                  right: 0,
                  child: Container(
                    height: 18,
                    width: 18,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: status == 'Offline'
                          ? Colors.amber
                          : Color(0xff31C911),
                      border: Border.all(
                          color: Colors.black,
                          style: BorderStyle.solid,
                          width: 3),
                    ),
                  ),
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 2),
              child: Text(
                description,
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
            ),
            Text(
              status,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: 'Quicksand',
                fontSize: 10,
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xFFFCFCFC),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4),
                    topRight: Radius.circular(4),
                    bottomLeft: Radius.circular(4),
                    bottomRight: Radius.circular(4),
                  ),
                ),
                child: Text(
                  'Accept',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Quicksand',
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4),
                    topRight: Radius.circular(4),
                    bottomLeft: Radius.circular(4),
                    bottomRight: Radius.circular(4),
                  ),
                ),
                child: Text(
                  'Deny',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Quicksand',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
