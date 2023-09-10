import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter_apps/Details.dart';
import 'package:permission_handler/permission_handler.dart';
import 'Cache_for_Contacts.dart';
//import 'provider';

class contacts extends StatefulWidget {
  @override
  contactState createState() => contactState();
}

class contactState extends State<contacts> {
  TextEditingController searchController=TextEditingController();
  void LoadSearch(List<Contact> Conts){
    searchedContNames=Conts;}
  void setSearch(String query){
    setState(() {
     searchedContNames= dispConts
          .where((contact){
          return contact.displayName!.toLowerCase().contains(query.toLowerCase());})
          .toList();
    });
  }
  @override
  void initState() {
    super.initState();
    if (dispConts.isEmpty) {
      requestPerm();
    }
  }

  Future<void> requestPerm() async {
    PermissionStatus stat = await Permission.contacts.request();
    if (stat.isGranted) {
      getDemConts();
    }
  }

  Future<void> getDemConts() async {
    List<Contact> conts = await ContactsService.getContacts();
    setState(() {
      dispConts = conts;
    });
    searchedContNames=dispConts;
  }


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(children: [
          Image.asset(
            'lib/assets/images/lightbluesky.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                toolbarHeight: 5,
                collapsedHeight: 5,
               pinned:true,
                backgroundColor: Colors.lightBlue[50],
               expandedHeight: 250.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25.0),
                  bottomRight: Radius.circular(25.0),
                )),
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: EdgeInsets.only(
                      top: 10.0, bottom: 80.0, right: 20.0, left: 25.0),
                  title:  ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        colors: [Colors.cyanAccent,Colors.greenAccent,Colors.tealAccent,Colors.white], // Define your gradient colors
                      ).createShader(bounds);
                    },
                    child: Text(
                      style: TextStyle(
                        fontFamily: 'Barlow',
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.cyanAccent[100],
                      ),
                      'Your\nContacts'),),
                  background: ClipRRect(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25.0),
                      bottomRight: Radius.circular(25.0),
                    ),
                    child: Image.asset(
                        'lib/assets/images/(without border)contacts.png',
                        fit: BoxFit.cover),
                  ),
                ),
                bottom:PreferredSize(
                  preferredSize: Size.fromHeight(kToolbarHeight+16),
                  child:
                      Card(shape:RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0))
                      ),
                         color:Colors.lightBlueAccent.withOpacity(0.1) ,
                          child: Padding(padding: EdgeInsets.all(0.0),
                    
                    child:  TextField(
                          controller: searchController,
                          onChanged: setSearch,
                          decoration: InputDecoration(
                            labelText: 'Search Contacts',
                            labelStyle: TextStyle(color: Colors.cyan[100]),
                            prefixIcon: Icon(Icons.person_search,color: Colors.cyan[100],),
                        )
                    ),
                  )),)
              ),
              if (dispConts.isEmpty)
                SliverFillRemaining(
                  child: Center(
                    child: Container(
                      constraints: BoxConstraints(
                          maxWidth: 220.0), // Set the minimum width
                      child: CircularProgressIndicator(
                        value: null,
                        backgroundColor: Colors.teal[100],
                        strokeWidth: 10,
                        color: Colors.teal[300], // Set the progress value (0.0 to 1.0)
                      ),
                    ),
                  ),
                )
              else
              SliverList.builder(
                itemCount: searchedContNames.length,
                itemBuilder: (context, index) => Column(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                      elevation: 0,
                      color: Colors.teal.withOpacity(0.1),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(9.0),
                        leading: CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.transparent,
                          backgroundImage: (searchedContNames[index].avatar != null &&
                                  searchedContNames[index].avatar!.isNotEmpty)
                              ? MemoryImage(searchedContNames[index].avatar!)
                              : AssetImage('lib/assets/images/contsgreen.png')
                                  as ImageProvider,
                        ),
                        title: Text(
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Barlow',
                                color: Colors.teal[700],
                                fontSize: 23.0),
                            searchedContNames[index].displayName ?? ''),
                        //tileColor: Colors.lightBlueAccent[100],

                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailsScreen(
                                        contact: searchedContNames[index],
                                        index: index,
                                      )));
                        },
                      ),
                    ),
                    //Divider(height: 2,),
                  ],
                ),
              ),

              /*SliverToBoxAdapter(
              child:Padding(
                padding: EdgeInsets.all(16.0),
                child: Image.asset('lib/assets/images/(without border)contacts.png',fit: BoxFit.fill,),
              ) ,
            ),*/
            ],
          )
        ]),
      ),
    );
  }
}
