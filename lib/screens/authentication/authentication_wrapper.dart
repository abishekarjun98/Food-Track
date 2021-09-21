import 'package:flutter/material.dart';
import 'package:food_track/models/user_type.dart';
import 'package:food_track/screens/authentication/login_screen.dart';
import 'package:food_track/screens/authentication/register_screen.dart';

class AuthenticationWrapper extends StatefulWidget {
  bool showSignUp;
  final UserType userType;

  AuthenticationWrapper({
    this.showSignUp = true,
    required this.userType,
  });
  @override
  _AuthenticationWrapperState createState() => _AuthenticationWrapperState();
}

class _AuthenticationWrapperState extends State<AuthenticationWrapper> {
  void toggleView() {
    //AuthService().signOut();
    setState(() {
      widget.showSignUp = !widget.showSignUp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.showSignUp
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
