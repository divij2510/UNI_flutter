import'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';

class contacts extends StatefulWidget{
  @override
  contactState createState() => contactState();
}

class contactState extends State<contacts>{
  Future<void> requestPerm() async{
    PermissionStatus stat= await Permission.contacts.request();
    if(stat.isGranted==true){
      getDemConts();
    }
  }
  Future<void> getDemConts() async{
   dispConts=await ContactsService.getContacts();

  }
 List<Contact> dispConts=[];

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home:Scaffold(
        body:CustomScrollView(
          slivers: [
            SliverAppBar(backgroundColor: Colors.redAccent,
              flexibleSpace: FlexibleSpaceBar( title:Text(style:TextStyle(fontSize:30) ,'Your Contacts'),
               ),
            ),
            SliverList.builder(itemBuilder:(context,index)=>
                ListTile(
                  title:Text(style:TextStyle(color:Colors.redAccent,fontSize: 20.0),
                      dispConts[index].displayName??''),
                  onTap: ()=>,
                ),
            ),
          ],
        ),
        ),
    );

  }
}