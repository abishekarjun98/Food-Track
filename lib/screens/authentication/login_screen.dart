//@dart=2.9
import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/masked_input_formatter.dart';
import 'package:food_track/api/api_manager.dart';
import 'package:food_track/cache/cache_manager.dart';
import 'package:food_track/models/auth_response.dart';
import 'package:food_track/models/login_request.dart';
import 'package:food_track/models/result_response.dart';
import 'package:food_track/models/user_type.dart';
import 'package:food_track/screens/customer/customer_home_screen.dart';
import 'package:food_track/screens/store/store_home_screen.dart';

class LoginScreen extends StatefulWidget {
  final Function toggleView;
  final UserType userType;

  LoginScreen({
    this.toggleView,
    this.userType,
  });
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String phoneNumber;
  String countryCodeString = '+91';
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController pwController = TextEditingController();
  final phoneFormKey = GlobalKey<FormState>();
  bool showPassword = false;
  ResultResponse<AuthResponse, String> _auth;
  bool isLoading = false;
  void loader() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: FloatingActionButton(
        child: Platform.isIOS
            ? Icon(Icons.arrow_forward_ios)
            : Icon(Icons.arrow_forward),
        onPressed: () async {
          var phno = "$countryCodeString${phoneController.text}";
          var pw = pwController.text;
          var request =
              LoginRequest(phonenumber: phno, password: pw, type: "sellers");
          loader();
          _auth = await ApiManager().login(request);
          var res = _auth.response as AuthResponse;
          loader();
          print(_auth.message);
          print("$countryCodeString${phoneController.text}");
          if (_auth.message == "success") {
            var cache = await CacheManager().cache();
            cache.storeCred(phno, res.token);
            Navigator.of(context).popAndPushNamed('/home');
          }
        },
      ),
      appBar: AppBar(
        title: Text("Food Track"),
      ),
      body: SafeArea(
        child: Center(
          child: isLoading
              ? CircularProgressIndicator.adaptive()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "LOGIN",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                                    color: Colors.white,
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
                            )),
                        Flexible(
                          flex: 3,
                          child: TextFormField(
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            maxLength: 12,
                            onChanged: (val) {},
                            decoration: InputDecoration(
                              counterText: '',
                              contentPadding: EdgeInsets.only(left: 24),
                              hintText: 'Phone number',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: TextFormField(
                          obscureText: showPassword,
                          controller: pwController,
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
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        TextButton(
                          onPressed: () => widget.toggleView(),
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
