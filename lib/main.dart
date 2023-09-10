import 'package:flutter/material.dart';
import 'package:flutter_apps/profileScreen.dart';
import 'package:flutter_apps/Contacts.dart';
import 'Cache_for_Contacts.dart';
import 'package:flutter_apps/Home.dart';
import 'weather.dart';

void main()=>runApp(MyApp());

class MyApp extends StatefulWidget{
  @override
appState createState()=> appState();
}
class appState extends State<MyApp>{
  var screenindex=1;
  List<Widget> screen=[profile(),home(),contacts(),WeatherWidget(weather: Weather(cityName: '', temperature: 0, description: ''))];
@override
  Widget build(BuildContext context){
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal)),
    title:'Divijs App',
    home: Scaffold(
      appBar: AppBar(
        /*leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.abc),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),*/
        title: Text('DM X UNI'),
      ),
     /* drawer: Drawer(
        child:ListView(
        padding:EdgeInsets.all(0.0),
          children: [
            GestureDetector(
              onTap:() {
                // Use a context that is within the Navigator's widget tree
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return profile(); // Replace with your profile screen widget
                }));
              },
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children:[
                      CircleAvatar(
                        //backgroundImage: Image.memory(),
                      ),
                      Text(name,style:TextStyle()),
                      Icon(Icons.arrow_forward_ios),
                    ]),),),
            ListTile(
              title: Text(email),
            ),
            ListTile(
              title: Text(phone),
            ),
            ListTile(
              title: Text(budda),
            ),

          ],


      ),
      ),*/
      body: screen[screenindex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: screenindex,
        onTap: (screen_index) {
          setState(() {
            screenindex=screen_index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.person_2_rounded),
              label: 'PROFILE',
            backgroundColor: Colors.teal
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.home_max_rounded),
              label: 'HOME',
              backgroundColor: Colors.teal
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.contact_emergency_rounded),
              label: 'CONTACTS',
              backgroundColor: Colors.teal
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.sunny),
              label: 'WEATHER',
              backgroundColor: Colors.teal
          ),

        ],
      ),
    ),
  );
}
}
