import 'package:flutter/material.dart';

class InputPage2 extends StatefulWidget {
  @override
  _InputPageState2 createState() => _InputPageState2();
}

class _InputPageState2 extends State<InputPage2> {
  TextEditingController _textEditingController = TextEditingController();
  DateTime? _selectedDate = DateTime.now();
  TimeOfDay? _selectedTime = TimeOfDay.now();

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
    print('Submitted: Text - ${_textEditingController.text}, Date - $_selectedDate, Time - $_selectedTime');
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
    child:  Center(
       child: Padding(
          padding: const EdgeInsets.all(16.0),
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [
             Container(
               child: Text(
                 'Enter Exit Data', // Added text
                 style: TextStyle(
                   color: Colors.white,
                   fontSize: 30,
                 ),
               ),
             ),
             SizedBox(height: 30), // Add spacing between input fields
             Container(
               width: isPortrait ? screenWidth * 0.8 : screenWidth * 0.5,
               padding: EdgeInsets.all(4),
               decoration: BoxDecoration(
                 color: Colors.black.withOpacity(0.8),
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
                onPressed: _submitForm,
                child: Text('Print'),
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
    );
  }
}
