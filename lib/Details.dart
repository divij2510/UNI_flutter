import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:contacts_service/contacts_service.dart';
import 'Cache_for_Contacts.dart';

class DetailsScreen extends StatelessWidget {
  DetailsScreen({required this.contact, required this.index}) {
    LoadPhone();
  }

  final Contact contact;
  final int index;
  late dynamic phoneNo;

  void LoadPhone() {
    if (contact.phones != null && contact.phones!.isNotEmpty) {
      phoneNo = contact.phones![0].value;
    } else {
      phoneNo = 'N.A.';
    }
  }

  @override
  Widget build(BuildContext context) {
    void _handleTap(int index, var phone, BuildContext context) async {
      String url = '';
      Uri uri = Uri.parse(url);
      final cleanedPhoneNumber =  phone.replaceAll(RegExp(r'[^\d]'), '');
      if (index == 0) {

        url = 'tel:$cleanedPhoneNumber'; // Phone call URL
      } else if (index == 1) {
        // WhatsApp URL (change the phone number as needed)
        url = 'https://wa.me/$cleanedPhoneNumber';
      }

      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        throw 'Could not launch $url';
      }
    }

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 180,
        flexibleSpace: FlexibleSpaceBar(
          titlePadding: EdgeInsets.only(top: 30, bottom: 30, right: 0, left: 19),
          title: ShaderMask(
            shaderCallback: (Rect bounds) => LinearGradient(
                colors: [Colors.cyanAccent, Colors.lightGreenAccent])
                .createShader(bounds),
            child: Text(
              '${contact.displayName}',
              style: TextStyle(fontSize: 30.0),
            ),
          ),
          background: Container(
            child: (dispConts[index].avatar != null && dispConts[index].avatar!.isNotEmpty)
                ? Image.memory(dispConts[index].avatar!,fit:BoxFit.cover)
                : Image.asset('lib/assets/images/newbagcon.jpg', fit: BoxFit.cover),
          ),
        ),
        backgroundColor: Colors.teal,
        elevation: 6,
      ),
      body: Padding(
        padding: EdgeInsetsDirectional.only(top: 30, start: 0, end: 20),
        child: ListView.builder(
          itemCount: 2,
          itemBuilder: (context, index) {
            Widget trail;
            String lab;
            if (index == 0) {
              trail = Icon(Icons.call,color: Colors.teal,);
              lab=phoneNo;
            } else {
              trail = Icon(Icons.chat_rounded,color: Colors.lightGreen);
              lab='WhatsApp';
            }
            return ListTile(
              trailing: trail,
              title: Text(
                '$lab',
                style: TextStyle(fontSize: 20.0, color: Colors.teal,fontWeight: FontWeight.w500),
              ),
              onTap: () => _handleTap(index, phoneNo, context),
            );
          },
        ),
      ),
    );
  }
}
