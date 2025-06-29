import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:parking/parking_owner_dashboard.dart';

class Dashboard_garage_owner extends StatefulWidget {
  final token;
  const Dashboard_garage_owner({@required this.token,Key? key}) : super(key: key);

  @override
  State<Dashboard_garage_owner> createState() => _Dashboard_garage_ownerState();
}

class _Dashboard_garage_ownerState extends State<Dashboard_garage_owner> {

  late var email;
  late var name;
  late var address;
  late var contact_number;
  late var Space;
  late var Cost_per_hr;
  late var Extra_cost;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Map<String,dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);

    email = jwtDecodedToken['email'];
    name = jwtDecodedToken['name'];
    address = jwtDecodedToken['address'];
    contact_number = jwtDecodedToken['contact_number'];
    Space = jwtDecodedToken['Space'];
    Cost_per_hr = jwtDecodedToken['Cost_per_hr'];
    Extra_cost = jwtDecodedToken['Extra_cost'];
  }
  @override
  Widget build(BuildContext context) {
    Color customBackgroundColor = Color(0xFFE7E4E4);
    return Scaffold(
        backgroundColor: customBackgroundColor,
      body:Center(
        child: Column(
            mainAxisAlignment :MainAxisAlignment.center,
            children:[
              Text('Welcome to পার্কিং চাই', style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold
              ),),
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.center, // Center the content vertically
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center, // Align children at the center of the row
                  children: [ // Add some space between the icon and text
                    Text(
                      name,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 30, fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Profile Information",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 35,fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CircleAvatar(
                radius: 70,
                //backgroundImage: NetworkImage(profile['profile_picture']),
                backgroundImage: AssetImage('assets/dp.png'),
              ),
              SizedBox(height: 20),
              Container(
                alignment: Alignment.center, // Center the content vertically
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center, // Align children at the center of the row
                  children: [
                    Icon(
                      Icons.email, // Replace 'your_icon' with the desired icon
                      color: Colors.black, // Set the color of the icon
                      size: 40, // Set the size of the icon
                    ),
                    SizedBox(width: 10), // Add some space between the icon and text
                    Text(
                      email,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center, // Center the content vertically
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center, // Align children at the center of the row
                  children: [
                    Icon(
                      Icons.location_on, // Replace 'your_icon' with the desired icon
                      color: Colors.black, // Set the color of the icon
                      size: 40, // Set the size of the icon
                    ),
                    SizedBox(width: 10), // Add some space between the icon and text
                    Text(
                      address,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center, // Align children at the center of the row
                  children: [
                  Icon(
                  Icons.phone,
                  color: Colors.black,
                  size: 40,
                ),
                SizedBox(width: 10),
                Text(contact_number.toString(), style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                  )),
                ]
                ),
              ),
              Container(
                alignment: Alignment.center, // Center the content vertically
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center, // Align children at the center of the row
                  children: [
                    Icon(
                      Icons.attach_money, // Replace 'your_icon' with the desired icon
                      color: Colors.black, // Set the color of the icon
                      size: 40, // Set the size of the icon
                    ),
                    SizedBox(width: 10), // Add some space between the icon and text
                    Text(Cost_per_hr.toString(), style: TextStyle(
                        color: Colors.black,
                        fontSize: 25
                    ),),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.center, // Center the content vertically
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center, // Align children at the center of the row
                  children: [
                    Text("Total Space:", style: TextStyle(
                        color: Colors.black,
                        fontSize: 30
                    ),),
                    SizedBox(width: 10), // Add some space between the icon and text
                    Text(Space.toString(), style: TextStyle(
                        color: Colors.black,
                        fontSize: 25
                    ),),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center, // Center the content vertically
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center, // Align children at the center of the row
                  children: [
                    Text("Extra hr cost:", style: TextStyle(
                        color: Colors.black,
                        fontSize: 30
                    ),),
                    SizedBox(width: 10), // Add some space between the icon and text
                    Text(Extra_cost.toString(), style: TextStyle(
                        color: Colors.black,
                        fontSize: 25
                    ),),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextButton(
                child: Text('NEXT'),
                onPressed: () {
                  Navigator.push(
                      context,MaterialPageRoute(builder: (contest) =>  parking_owner_dashboard()));

                },
                style: TextButton.styleFrom(
                  padding:const EdgeInsets.all(15),
                  foregroundColor: Colors.white,
                  backgroundColor:Colors.black.withOpacity(0.8), // Add opacity to make it slightly transparent
                  textStyle: const TextStyle(fontSize: 20),

                ),
              )
            ]
        )

      )

    );
  }
}
