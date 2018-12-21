import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:workshop_chat/Modules/Chat/ChatController.dart';

class ContactsPage extends StatefulWidget {
  final FirebaseUser currentUser;

  const ContactsPage({Key key, this.currentUser}) : super(key: key);

  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream:
            Firestore.instance.collection('users').orderBy('name').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error'),
            );
          }

          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: Text('Carregando...'),
              );
            default:
              List<DocumentSnapshot> docs = snapshot.data.documents;
              return ListView.builder(
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      showChat(docs[index]);
                    },
                    child: cardRow(docs[index]),
                  );
                },
              );
          }
        },
      ),
    );
  }

  void showChat(DocumentSnapshot contact) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return ChatController(
          userName: contact['name'],
          userUid: contact['uid'],
        );
      }),
    );
  }

  Widget cardRow(DocumentSnapshot doc) {
    return Container(
      height: 80.0,
      child: Row(
        children: <Widget>[
          SizedBox(width: 16.0),
          ClipRRect(
            borderRadius: BorderRadius.circular(25.0),
            child: Container(
              width: 50.0,
              height: 50.0,
              color: Colors.red,
              child: Center(
                child: Text(
                  doc['name'].toString().substring(0, 1).toUpperCase(),
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  doc['name'],
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  doc['email'],
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
