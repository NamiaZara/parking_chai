import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:parking/entry_time_print.dart';
import 'package:parking/home.dart';
import 'package:parking/dashboard_3.dart';
import 'package:parking/parking-history.dart';
import 'package:http/http.dart' as http;
import 'config.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  TextEditingController _carNumberController = TextEditingController();
  TextEditingController _NameController = TextEditingController();
  DateTime? _selectedDate = DateTime.now();
  TimeOfDay? _selectedTime = TimeOfDay.now();

  bool _isNotValidate = false;

  void entry_data() async{
    if(_carNumberController.text.isNotEmpty && _NameController.text.isNotEmpty && _selectedDate != null && _selectedTime != null){
      var regBody = {
        "car_number": _carNumberController.text,
        "name": _NameController.text, //making object
        "entry_date": _selectedDate!.toIso8601String(), // Convert DateTime to a string
        "entry_time": "${_selectedTime!.hour}:${_selectedTime!.minute}" // Convert TimeOfDay to a formatted string
      };
      var response = await http.post(Uri.parse(entry_data_car),
          headers: {"Content-Type":"application/json"},
          body: jsonEncode(regBody)
      );
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse['status']);
      if(jsonResponse['status']){
        //Navigator.push(context, MaterialPageRoute(builder: (context)=>YourScreen()));
        _submitForm();
      }else{
        print("SomeThing Went Wrong");
      }
    }else{
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
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDatePickerMode: DatePickerMode.day,
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark(), // Set the theme to dark
          child: child!,
        );
      },
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
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark(), // Set the theme to dark
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _submitForm() {
    // TODO: Implement the action you want to perform when the "Submit" button is clicked.
    print('Submitted: Car Number - ${_carNumberController.text},'
        ' Name - ${_NameController.text}, '
        'Date - $_selectedDate, '
        'Time - $_selectedTime');
    _showPopupMessage();
  }

  @override
  Widget build(BuildContext context) {
    bool isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
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
              // Handle profile icon tap
            },
          ),
        ],
      ),
    body: Container(
      decoration: BoxDecoration(
         image: DecorationImage(
           image: AssetImage('assets/p2.jpg'), // Replace with your image asset path
           fit: BoxFit.cover,
         ),
       ),
    child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
            child: Text(
              'Enter Entry Data', // Added text
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
          ),
              SizedBox(height: 20), // Add spacing between input fields
              Container(
                width: isPortrait ? screenWidth * 0.8 : screenWidth * 0.5,
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(10),
                ),

                child: TextField(
                  controller: _carNumberController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    errorText: _isNotValidate ? "Enter Proper Car number" : null,
                    hintText: 'Car Number',
                    hintStyle: TextStyle(color: Colors.white),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
              ),
              SizedBox(height: 10), // Add spacing between input fields
              Container(
                width: isPortrait ? screenWidth * 0.8 : screenWidth * 0.5,
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.8), // Add opacity to make it slightly transparent
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: _NameController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    errorText: _isNotValidate ? "Enter Proper name" : null,
                    hintText: 'Name',
                    hintStyle: TextStyle(color: Colors.white),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.8), // Add opacity to make it slightly transparent
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
                  color: Colors.black.withOpacity(0.8), // Add opacity to make it slightly transparent
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
                  entry_data();
                },
                //_submitForm,
                child: Text('Done'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black.withOpacity(0.8), // Add opacity to make it slightly transparent
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
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



//zara's code
  void _showPopupMessage() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Data Saved"),
          content: Text("Print copy?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("No",style: TextStyle(
                color: Colors.black,
              ),),
            ),
            TextButton(
              onPressed: _createPDF,
              child: Text("Yes",style: TextStyle(
                color: Colors.black,
              ),),
            ),
          ],
        );
      },
    );
  }

  Future<void> _createPDF() async {
    final PdfDocument document = PdfDocument();
    final page = document.pages.add();

    final PdfStandardFont font = PdfStandardFont(PdfFontFamily.helvetica, 24, style: PdfFontStyle.bold);

    // Draw the input data along with the static text
    final String carNumber = _carNumberController.text;
    final String name = _NameController.text;
    final String selectedDate = _selectedDate?.toLocal().toString().split(' ')[0] ?? "";
    final String selectedTime = _selectedTime!.format(context);

    final PdfStringFormat centerFormat = PdfStringFormat(alignment: PdfTextAlignment.center);
    page.graphics.drawString('Parking Chai', font, brush: PdfSolidBrush(PdfColor(0, 0, 0)), bounds: Rect.fromLTWH(0, 50, page.getClientSize().width, 40), format: centerFormat);
    page.graphics.drawString('Car Number: $carNumber', font, bounds: Rect.fromLTWH(50, 100, 200, 40));
    page.graphics.drawString('Name: $name', font, bounds: Rect.fromLTWH(50, 150, 200, 40));
    page.graphics.drawString('Date: $selectedDate', font, bounds: Rect.fromLTWH(50, 200, 200, 40));
    page.graphics.drawString('Time: $selectedTime', font, bounds: Rect.fromLTWH(50, 250, 200, 40));

    // Save the PDF document and get the bytes
    final List<int> bytes = await document.save(); // Use 'await' here

    // Dispose of the document
    document.dispose();

    // Now you can work with the 'bytes' variable
    saveAndLaunchFile(bytes, 'Entry time.pdf');
  }

}


