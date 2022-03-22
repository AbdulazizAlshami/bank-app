import 'package:flutter/material.dart';

import 'make_trans.dart';
import 'reports.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  List Pages = [
    const MakeTrans(),
     TransReport(),
  ];
  int currentIndex = 0;

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        body: Pages[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          selectedFontSize: 15,
          unselectedFontSize: 0,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          onTap: onTap,
          currentIndex: currentIndex,
          selectedItemColor: Colors.black54,
          unselectedItemColor: Colors.grey.withOpacity(0.5),
          showSelectedLabels: true,
          showUnselectedLabels: false,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
                label: "Make Transactions", icon: Icon(Icons.money)),
            BottomNavigationBarItem(
                label: "Transactions Reports", icon: Icon(Icons.report)),
          ],
        ),
      ),
    );
  }
}
