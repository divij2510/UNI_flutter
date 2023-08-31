import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class profile extends StatefulWidget{
  @override
  _profileState createState(){
    return _profileState();
  }
}
class _profileState extends State<profile>{
  @override
Widget build(BuildContext context){
    return Padding(
          padding:const EdgeInsets.all(16.0) ,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  hintText: 'eg.Divij Mehta',
                ),),
              TextField(
                controller: _buddayController,
                decoration: InputDecoration(
                  labelText: 'Birthday',
                  hintText: 'eg.25/10/2004',
                ),),

          TextField(
            controller: _PhoneNoController,
            decoration: InputDecoration(
              labelText:'Mobile Number',
              hintText: 'eg.9929992999',
            ),
          ),
             TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText:'Email ID',
                  hintText: 'eg.divijmehta25@gmail.com',
                ),
              ),
              SizedBox(
                height: 20,
              ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        child: Text('Clear All'),
                        onPressed: ClearAll,
                    ),
                    ElevatedButton(
                      child: Text('Save itt!'),
                      onPressed: Save,
                    ),
                  ],
                ),



              ]),
              );

}
String GetName(){
    return _nameController.text;
}
  TextEditingController _nameController=TextEditingController();
TextEditingController _buddayController=TextEditingController();
TextEditingController _PhoneNoController=TextEditingController();
TextEditingController _emailController=TextEditingController();

Future<void> Load() async{
  SharedPreferences prefs= await SharedPreferences.getInstance();
  _nameController.text=prefs.getString('name')??'';
  _PhoneNoController.text=prefs.getString('Phone')??'';
  _buddayController.text=prefs.getString('budday')??'';
  _emailController.text=prefs.getString('email')??'';
}
Future<void> Save() async{
  SharedPreferences prefs=await SharedPreferences.getInstance();
  prefs.setString('name', _nameController.text);
  prefs.setString('Phone', _PhoneNoController.text);
  prefs.setString('budday', _buddayController.text);
  prefs.setString('email', _emailController.text);
}
void ClearAll(){
  setState(() {
    _buddayController.clear();
    _nameController.clear();
    _PhoneNoController.clear();
    _emailController.clear();
  });
  Save();
}
@override
void initState()
{
  super.initState();
  Load();
}
}
class home extends StatelessWidget{
  var pstate=_profileState();
  @override
  Widget build(BuildContext context){
    return Center(child: Column(
      children: [
        SizedBox(height: 260,),
        Text(style:TextStyle(fontSize:50,color: Colors.red) ,'Welcome! '),
        Text(style:TextStyle(fontSize:30,color: Colors.pink),pstate.GetName()),
    ],),
    );
  }
}