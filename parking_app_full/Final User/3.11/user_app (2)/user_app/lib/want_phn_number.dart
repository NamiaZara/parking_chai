import 'package:flutter/material.dart';
import 'package:user_app/create_account_user.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PhoneNumberPage extends StatelessWidget {
  TextEditingController user_contact_numberController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Color customBackgroundColor = Color(0xFFE7E4E4);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 30, top: 170,right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'পার্কিং \nচাই',
              style: TextStyle(
                color: Colors.black,
                fontSize: 54,
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  InternationalPhoneNumberInput(
                    onInputChanged: (PhoneNumber phoneNumber) {
                      user_contact_numberController.text = phoneNumber.toString();
                    },
                    selectorConfig: SelectorConfig(
                      selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                      setSelectorButtonAsPrefixIcon: true,
                      leadingPadding: 0,
                    ),
                    initialValue: PhoneNumber(isoCode: 'BD'),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Phone number is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {

                      if (_formKey.currentState!.validate()) {
                        Navigator.push(
                            context,MaterialPageRoute(builder: (contest) =>  create_user_account())); // Perform your registration logic here
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black, // Change the button color to black
                    ),
                    child: Text('Next'),
                  )

                ],
              ),
            ),
            SizedBox(height: 40),

            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'By tapping "Next" you agree to ',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  GestureDetector(
                    onTap: () {
                      //Navigator.push(
                        //context,
                       // MaterialPageRoute(builder: (context) => User_Login()),);
                    },
                    child: Text(
                      "Privacy Policy",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            )


          ],
        ),
      ),
    );
  }
}


