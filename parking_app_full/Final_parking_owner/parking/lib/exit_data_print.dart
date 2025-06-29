import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:parking/home.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:parking/parking_owber_profile_info_show.dart';
import 'package:parking/parking-history.dart';
import 'package:http/http.dart' as http;
import 'config.dart';
import 'dart:convert';

class InputPage1 extends StatefulWidget {
  final token;
  const InputPage1({@required this.token,Key? key}) : super(key:key);
  @override
  _InputPageState1 createState() => _InputPageState1();
}

class _InputPageState1 extends State<InputPage1> {
  String? userID;
  TextEditingController _textEditingController = TextEditingController();
  DateTime? _selectedDate = DateTime.now();
  TimeOfDay? _selectedTime = TimeOfDay.now();

  void initState() {
    super.initState();
    print('Received JWT Token: ${widget.token}');
    try {
      Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
      print('Decoded Token: $jwtDecodedToken');
      userID = jwtDecodedToken['_id'];
      print('User ID: $userID');
    } catch (e) {
      print('JWT decoding error: $e');
    }
  }
  /*void initState() {
    super.initState();
    print('Received JWT Token: ${widget.token}');
    try {
      Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
      print('Decoded Token: $jwtDecodedToken');
      userEmail = jwtDecodedToken['email']; // Change this to 'email'
      print('User Email: $userEmail');
    } catch (e) {
      print('JWT decoding error: $e');
    }
  }*/


  bool _isNotValidate = false;
  void exit_data() async{
    if (_textEditingController.text.isNotEmpty && _selectedDate != null && _selectedTime != null) {
      var regBody = {
        "userID":userID,
        "car_number": _textEditingController.text,
        "exit_date": _selectedDate!.toIso8601String(),
        "exit_time": "${_selectedTime!.hour}:${_selectedTime!.minute}"
      };
      /*void exit_data() async {
    if (_textEditingController.text.isNotEmpty &&
        _selectedDate != null &&
        _selectedTime != null) {
      var regBody = {
        "userEmail": userEmail, // Change this to 'userEmail'
        "car_number": _textEditingController.text,
        "exit_date": _selectedDate!.toIso8601String(),
        "exit_time": "${_selectedTime!.hour}:${_selectedTime!.minute}"
      };*/
      try {
        var response = await http.post(
          Uri.parse(exit_data_car),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(regBody),
        );

        if (response.statusCode == 200) {
          var jsonResponse = jsonDecode(response.body);
          print(jsonResponse['status']);
          if (jsonResponse['status']) {
            // Request was successful
            _submitForm();
          } else {
            print("Something Went Wrong");
          }
        } else {
          print("HTTP Request failed with status code: ${response.statusCode}");
        }
      } catch (e) {
        print("An error occurred: $e");
      }
    } else {
      setState(() {
        _isNotValidate = true;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate!,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime!,
    );

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _submitForm() {
    print('Submitted: Car Number - ${_textEditingController.text},'
        'Date - $_selectedDate, '
        'Time - $_selectedTime');
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          final formattedTime = '${_selectedTime!.hour}:${_selectedTime!.minute}';
          return pw.Column(
            children: [
              // Title "Exit Slip" in a bar
              pw.Container(
                color: PdfColors.black,
                height: 40, // Adjust the height of the top bar
                padding: pw.EdgeInsets.all(10),
                child: pw.Center(
                  child: pw.Text('Exit Slip', style: pw.TextStyle(fontSize: 20, color: PdfColors.white)),
                ),
              ),
              pw.Center(
                child: pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: <pw.Widget>[
                    pw.Text('Car Number: ${_textEditingController.text}', style: pw.TextStyle(fontSize: 18)),
                    pw.Text('Date: ${_selectedDate?.toLocal().toString().split(' ')[0] ?? ""}', style: pw.TextStyle(fontSize: 18)),
                    pw.Text('Time: $formattedTime', style: pw.TextStyle(fontSize: 18)),
                  ],
                ),
              ),

            ],
          );
        },
      ),
    );

    Printing.layoutPdf(onLayout: (format) async => pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Exit Data'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: isPortrait ? screenWidth * 0.8 : screenWidth * 0.5,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: _textEditingController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Car Number',
                    labelStyle: TextStyle(color: Colors.white),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: GestureDetector(
                  onTap: () => _selectDate(context),
                  child: Text(
                    'Select Date: ${_selectedDate?.toLocal().toString().split(' ')[0] ?? ""}',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: GestureDetector(
                  onTap: () => _selectTime(context),
                  child: Text(
                    'Select Time: ${_selectedTime!.format(context)}',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: (){
                  exit_data();
                },
                child: Text('Print'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
      // Bottom app bar
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
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                    // Implement the action for the first icon here
                  },
                ),
                IconButton(
                  icon: Icon(Icons.verified_user, color: Colors.white),
                  onPressed: () {
                    // Implement the action for the first icon here
                  },
                ),
                IconButton(
                  icon: Icon(Icons.history, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Scene()),
                    );
                    // Implement the action for the second icon here
                  },
                ),
              ],
            ),
            SizedBox(height: 5), // Adjust spacing between icons and names
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Center(child: Text('  Home', style: TextStyle(color: Colors.white))),
                Center(child: Text('Permission', style: TextStyle(color: Colors.white))),
                Center(child: Text('History', style: TextStyle(color: Colors.white))),

              ],
            ),
          ],
        ),
      ),
    );
  }
}