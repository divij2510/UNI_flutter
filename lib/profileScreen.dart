import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_apps/Cache_for_Contacts.dart';

TextEditingController nameController=TextEditingController();
TextEditingController _buddayController=TextEditingController();
TextEditingController _PhoneNoController=TextEditingController();
TextEditingController _emailController=TextEditingController();
class profile extends StatefulWidget{
  @override
  _profileState createState(){
    return _profileState();
  }
}
class _profileState extends State<profile> {
  bool isEditing = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'Full Name',
              hintText: 'eg.Divij Mehta',
            ),
            enabled: isEditing,
          ),
          TextField(
            controller: _buddayController,
            decoration: InputDecoration(
              labelText: 'Birthday',
              hintText: 'eg.25/10/2004',
            ),
            enabled: isEditing,
          ),
          TextField(
            controller: _PhoneNoController,
            decoration: InputDecoration(
              labelText: 'Mobile Number',
              hintText: 'eg.9929992999',
            ),
            enabled: isEditing,
          ),
          TextField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Email ID',
              hintText: 'eg.divijmehta25@gmail.com',
            ),
            enabled: isEditing,

          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                child: Text(isEditing ? 'Clear All' : 'Edit'),
                onPressed: isEditing ? ClearAll : toggleEditing,
              ),
              ElevatedButton(
                child: Text('Save itt!'),
                onPressed: isEditing ? Save : null,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void toggleEditing() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  void ClearAll() {
    setState(() {
      nameController.clear();
      _buddayController.clear();
      _PhoneNoController.clear();
      _emailController.clear();
    });
  }

  void Save() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString('name', nameController.text);
      prefs.setString('Phone', _PhoneNoController.text);
      prefs.setString('budday', _buddayController.text);
      prefs.setString('email', _emailController.text);
    });

    // Disable editing after saving
    setState(() {
      isEditing = false;
    });
  }
}
