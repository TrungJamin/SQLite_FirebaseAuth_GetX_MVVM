import 'package:first_project_login_and_register/screens/DetailScreen/detail_screen.dart';
import 'package:first_project_login_and_register/services/authentication_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/body.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/homeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final tabs = [
    Center(
      child: Body(),
    ),
    DetailScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_currentIndex == 0 ? "Home" : "Detail"),
        centerTitle: true,
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              leading: Icon(Icons.close),
              title: Text('Close drawer'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text(
                'Log out',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onTap: () async {
                await context.read<AuthenticationService>().signOut();
                Navigator.of(context).pushNamedAndRemoveUntil(
                    '/loginScreen', (Route<dynamic> route) => false);
              },
            )
          ],
        ),
      ),
      body: tabs[_currentIndex],
      bottomNavigationBar: Container(
        child: BottomNavigationBar(
          selectedFontSize: 20,
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('Home'),
                backgroundColor: Colors.blue),
            BottomNavigationBarItem(
                icon: Icon(Icons.details),
                title: Text('Detail'),
                backgroundColor: Colors.blue)
          ],
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
