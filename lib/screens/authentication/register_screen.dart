import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:food_track/models/user_type.dart';
import 'package:food_track/screens/customer/customer_home_screen.dart';
import 'package:food_track/screens/store/store_home_screen.dart';

class RegisterScreen extends StatefulWidget {
  final Function toggleView;
  final UserType userType;

  RegisterScreen({
    required this.toggleView,
    required this.userType,
  });
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? phoneNumber;
  String? countryCodeString = '+91';
  final TextEditingController phoneController = TextEditingController();
  final phoneFormKey = GlobalKey<FormState>();
  bool showPassword = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Food Track"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => widget.userType == UserType.store
                ? StoreHomeScreen()
                : CustomerHomeScreen(),
          ),
        ),
        child: Platform.isIOS
            ? Icon(Icons.arrow_forward_ios)
            : Icon(Icons.arrow_forward),
      ),
      body: SafeArea(
        child: Center(
          child: isLoading
              ? CircularProgressIndicator.adaptive()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'SIGN UP',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    Row(
                      children: [
                        Flexible(
                          flex: 2,
                          child: CountryCodePicker(
                            showDropDownButton: true,
                            textStyle: TextStyle(color: Color(0xFF1C2745)),
                            searchDecoration: InputDecoration(
                              hintText: 'Country code',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide(
                                  color: Color(0xFF9BA6B8),
                                ),
                              ),
                            ),
                            onChanged: (CountryCode code) {
                              countryCodeString = code.toString();
                            },
                            // Initial selection and favorite can be one of code ('US') OR dial_code('+1')
                            initialSelection: 'IN',
                            favorite: ['+91', 'IN'],
                            // optional. Shows only country name and flag
                            showCountryOnly: false,
                            // optional. Shows only country name and flag when popup is closed.
                            showOnlyCountryWhenClosed: false,
                            // optional. aligns the flag and the Text left
                            alignLeft: false,
                          ),
                        ),
                        Flexible(
                          flex: 3,
                          child: TextFormField(
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            maxLength: 12,
                            inputFormatters: [
                              MaskedInputFormatter('### ### ####'),
                            ],
                            onChanged: (val) {},
                            decoration: InputDecoration(
                              counterText: '',
                              contentPadding: EdgeInsets.only(left: 20),
                              hintText: 'Phone number',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide(
                                  color: Color(0xFF9BA6B8),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        obscureText: showPassword,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                showPassword = !showPassword;
                              });
                            },
                            icon: showPassword
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                          ),
                          contentPadding: EdgeInsets.only(left: 20),
                          hintText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: Color(0xFF9BA6B8),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        obscureText: showPassword,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                showPassword = !showPassword;
                              });
                            },
                            icon: showPassword
                                ? Icon(Icons.visibility_off)
                                : Icon(Icons.visibility),
                          ),
                          contentPadding: EdgeInsets.only(left: 20),
                          hintText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(
                              color: Color(0xFF9BA6B8),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Have an account?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        TextButton(
                          onPressed: () => widget.toggleView(),
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
