import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:workshop_chat/Modules/Chat/ChatController.dart';

class MessagesController extends StatefulWidget {
  final FirebaseUser currentUser;

  const MessagesController({Key key, this.currentUser}) : super(key: key);

  @override
  _MessagesControllerState createState() => _MessagesControllerState();
}

class _MessagesControllerState extends State<MessagesController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: Firestore.instance
            .collection('messages')
            .orderBy('timestamp')
            .snapshots(),
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

  void showChat(DocumentSnapshot doc) {
    if (doc['uidFrom'] == widget.currentUser.uid) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return ChatController(
            userName: doc['nameTo'],
            userUid: doc['uidTo'],
          );
        }),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return ChatController(
            userName: doc['nameFrom'],
            userUid: doc['uidFrom'],
          );
        }),
      );
    }
  }

  Widget cardRow(DocumentSnapshot doc) {
    if (doc['uidFrom'] == widget.currentUser.uid) {
      // eu que estou enviando msg
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
                    doc['nameTo'].toString().substring(0, 1).toUpperCase(),
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
                    doc['nameTo'],
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    doc['preview'],
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
    } else {
      // estou recebendo msg
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
                    doc['nameFrom'].toString().substring(0, 1).toUpperCase(),
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
                    doc['nameFrom'],
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    doc['preview'],
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
}
