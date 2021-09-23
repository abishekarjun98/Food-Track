//@dart=2.9
import 'package:flutter/material.dart';
import 'package:food_track/models/user_type.dart';
import 'package:food_track/screens/authentication/login_screen.dart';
import 'package:food_track/screens/authentication/register_screen.dart';

class AuthenticationScreen extends StatefulWidget {
  final UserType userType;

  AuthenticationScreen({Key key, this.userType}) : super(key: key);

  @override
  _AuthenticationWrapperState createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationScreen> {
  bool showSignUp = false;
  void toggleView() {
    //AuthService().signOut();
    setState(() {
      showSignUp = !showSignUp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return showSignUp
        ? RegisterScreen(
            toggleView: toggleView,
            userType: widget.userType,
          )
        : LoginScreen(
            toggleView: toggleView,
            userType: widget.userType,
          );
  }
}
