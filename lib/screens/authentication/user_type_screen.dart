import 'package:flutter/material.dart';
import 'package:food_track/models/user_type.dart';
import 'package:food_track/screens/authentication/authentication_wrapper.dart';

class UserTypeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'WELCOME TO HACKATHON',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'ARE YOU A STORE OR A CUSTOMER?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AuthenticationWrapper(
                        showSignUp: true,
                        userType: UserType.store,
                      ),
                    ),
                  ),
                  icon: Icon(Icons.store),
                  label: Text('Store'),
                ),
                ElevatedButton.icon(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AuthenticationWrapper(
                        showSignUp: true,
                        userType: UserType.customer,
                      ),
                    ),
                  ),
                  icon: Icon(Icons.people),
                  label: Text('Customer'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
