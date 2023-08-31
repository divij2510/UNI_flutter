import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'profileScreen.dart';

void main()=>runApp(MyApp());

class MyApp extends StatefulWidget{
  @override
appState createState()=> appState();
}
class appState extends State<MyApp>{
  var screenindex=1;
  List<Widget> screen=[profile(),home(),];
@override
  Widget build(BuildContext context){
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent)),
    title:'Divijs App',
    home: Scaffold(
      appBar: AppBar(
        title: Text('My UniCode App'),
      ),
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
              label: 'PROFILE'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.home_max_rounded),
              label: 'HOME'
          ),

        ],
      ),
    ),
  );
}
}
