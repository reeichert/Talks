import 'package:flutter/material.dart';
import 'package:workshop_chat/Modules/Dashboard/ContactsPage.dart';
import 'package:workshop_chat/Modules/Dashboard/MessagesPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:workshop_chat/Modules/Login/LoginController.dart';

class DashboardController extends StatefulWidget {
  @override
  _DashboardControllerState createState() => _DashboardControllerState();
}

class _DashboardControllerState extends State<DashboardController> {
  int _selectedIndex = 0;
  FirebaseUser currentUser;

  var _pages;

  @override
  void initState() {
    super.initState();

    getUser();
  }

  getUser() async {
    var user = await FirebaseAuth.instance.currentUser();

    _pages = [
      MessagesController(currentUser: user),
      ContactsPage(currentUser: user)
    ];

    setState(() {
      this.currentUser = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WhatsTop'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              _logoutUser();
            },
          )
        ],
      ),
      body: this.currentUser == null
          ? Center(child: CircularProgressIndicator())
          : _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Conversas'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            title: Text('Contatos'),
          ),
        ],
      ),
    );
  }

  void _logoutUser() async {
    await FirebaseAuth.instance.signOut();

    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) {
      return LoginController();
    }));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
