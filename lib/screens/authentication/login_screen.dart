//@dart=2.9
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
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              brightness: Brightness.dark,
              title: Text("FoodTruck"),
              backgroundColor: Colors.black,
            ),
            body: Stack(children: [
              Center(
                child: SingleChildScrollView(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding:
                          EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey.withOpacity(0.25)),
                      child: Form(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "LOGIN",
                            style: TextStyle(fontSize: 40),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                  flex: 2,
                                  child: CountryCodePicker(
                                    showDropDownButton: true,
                                    textStyle:
                                        TextStyle(color: Color(0xFF1C2745)),
                                    searchDecoration: InputDecoration(
                                      hintText: 'Country code',
                                      hintStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                      ),
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
                                    hintStyle: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 14,
                                    ),
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
                          SizedBox(height: 10),
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
                                  hintStyle: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 14,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(5),
                                    borderSide: BorderSide(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )),
                          SizedBox(
                            height: 20,
                          ),
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
                              ]),
                          SizedBox(height: 30),
                          Builder(
                              builder: (context) => ElevatedButton(
                                    child: isLoading
                                        ? Container(
                                            padding: EdgeInsets.all(4),
                                            child: CircularProgressIndicator(
                                                strokeWidth: 3,
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                        Color>(Colors.white)))
                                        : Text("LOGIN"),
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty
                                          .resolveWith<Color>(
                                        (Set<MaterialState> states) {
                                          if (isLoading)
                                            return Colors.transparent;
                                          if (states
                                              .contains(MaterialState.pressed))
                                            return Theme.of(context)
                                                .colorScheme
                                                .primary
                                                .withOpacity(0.5);
                                          else if (states
                                              .contains(MaterialState.hovered))
                                            return Colors.lightGreen;
                                          return Colors
                                              .green; // Use the component's default.
                                        },
                                      ),
                                    ),
                                    onPressed: () async {
                                      var phno =
                                          "$countryCodeString${phoneController.text}";
                                      var pw = pwController.text;
                                      var request = LoginRequest(
                                          phonenumber: phno,
                                          password: pw,
                                          type: "sellers");
                                      loader();
                                      _auth = await ApiManager().login(request);
                                      var res = _auth.response as AuthResponse;
                                      loader();
                                      print(_auth.message);
                                      print(
                                          "$countryCodeString${phoneController.text}");
                                      if (_auth.message == "success") {
                                        var cache =
                                            await CacheManager().cache();
                                        cache.storeCred(phno, res.token);
                                        Navigator.of(context)
                                            .popAndPushNamed('/home');
                                      }
                                    },
                                  ))
                        ],
                      )),
                    ),
                  ],
                )),
              ),
            ])));
  }
}
