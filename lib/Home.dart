import 'package:flutter/material.dart';
class home extends StatelessWidget {
  home();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(height: 260),
          Text(
            'Welcome!',
            style: TextStyle(
              fontFamily: 'Barlow',
              fontWeight: FontWeight.bold,
              fontSize: 50,
              color: Colors.teal,
            ),
          ),
        ],
      ),
    );
  }
}