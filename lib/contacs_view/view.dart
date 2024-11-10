import 'package:buble_talk/utils/helpers/cutom_show_msg.dart';
import 'package:buble_talk/views/chat_page/view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:permission_handler/permission_handler.dart';
import '../utils/constans.dart';
class ContactsView extends StatefulWidget {
  const ContactsView({super.key});
static String id ="contacs";
  @override
  State<ContactsView> createState() => _ContactsViewState();
}

class _ContactsViewState extends State<ContactsView> {
  List<Contact> _contacts=[];
  Future<void> fetchContacts() async {
    var status = await Permission.contacts.status;
    if (!status.isGranted) {
      await Permission.contacts.request();
    }
    if (await Permission.contacts.isGranted) {
      List<Contact> contacts = await FlutterContacts.getContacts(withProperties: true);
      setState(() {
        _contacts = contacts;
      });
    }else{
      showToast(context, "Please enable access to show your contacs");
    }
  }

  @override
  void initState() {
    print(_contacts.length);

    super.initState();
    fetchContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
    body:_contacts.isEmpty?Image.network(''):
    SafeArea(
      child: Column(
          children: [
          const  SizedBox(height: 15,),
       const Text('Contacts',style: kTextStyle24white,),
          const  SizedBox(height: 6,),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) =>const Divider(thickness: 0.2,),
                itemCount: _contacts.length,
                itemBuilder: (context, index) {
              Contact contact = _contacts[index];
              return GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChatPageView(chatId: contact.id,),));
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0,left: 10,bottom: 0,top: 0),
                  child: ListTile(
                    title: Text(contact.displayName ?? 'No name',style: kTextStyle20white,),

                    subtitle: Text(
                        contact.phones.isNotEmpty ? contact.phones.first.number ??
                            'No phone' : 'No phone',style: kTextStyle14White),
                  ),
                ),
              );
                    }),
            ),
          ],
        ),
    )
    );
}}
