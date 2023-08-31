import 'package:flutter/material.dart';
import 'Contacts.dart';
class DetailsCont extends StatelessWidget{
  Widget build(BuildContext context){
    return Scaffold(
      body:Padding(
       padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(contactState.dispConts[index].displayName??''),
          ],
        ),
      ),
      appBar: AppBar(
        title:Text(style:TextStyle( ),'Details for yaa'),
      ),
    );
  }
}