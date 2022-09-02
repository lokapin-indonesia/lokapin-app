import 'package:flutter/material.dart';
import 'package:lokapin_app/screen/construction_screen.dart';
import 'package:lokapin_app/screen/maps/maps_screen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:lokapin_app/screen/home/home_screen.dart';

import '../screen/maps/maps_screen.dart';

class NavBar extends StatefulWidget {
  static String tag = '/NavBar';

  const NavBar({Key? key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    MapScreen(),
    ConstructionScreen(),
    ConstructionScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10), topLeft: Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.25),
                  spreadRadius: 0,
                  blurRadius: 4),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0)),
            child: BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              unselectedFontSize: 0.0,
              selectedFontSize: 0.0,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    label: "",
                    icon: const CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.white,
                        child: IconButton(
                            onPressed: null,
                            icon: Icon(
                              Icons.home,
                              color: Colors.black,
                            ))).paddingAll(10),
                    activeIcon: const CircleAvatar(
                        radius: 25,
                        backgroundColor: Color.fromRGBO(139, 208, 252, 1),
                        child: IconButton(
                            onPressed: null,
                            icon: Icon(
                              Icons.home,
                              color: Colors.white,
                            ))).paddingAll(10)),
                const BottomNavigationBarItem(
                    icon: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.white,
                        child: IconButton(
                            onPressed: null,
                            icon: Icon(
                              Icons.map,
                              color: Colors.black,
                            ))),
                    label: '',
                    activeIcon: CircleAvatar(
                        radius: 25,
                        backgroundColor: Color.fromRGBO(139, 208, 252, 1),
                        child: IconButton(
                            onPressed: null,
                            icon: Icon(
                              Icons.map,
                              color: Colors.white,
                            )))),
                const BottomNavigationBarItem(
                    icon: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.white,
                        child: IconButton(
                            onPressed: null,
                            icon: Icon(
                              Icons.location_searching,
                              color: Colors.black,
                            ))),
                    label: '',
                    activeIcon: CircleAvatar(
                        radius: 25,
                        backgroundColor: Color.fromRGBO(139, 208, 252, 1),
                        child: IconButton(
                            onPressed: null,
                            icon: Icon(
                              Icons.location_searching,
                              color: Colors.white,
                            )))),
                const BottomNavigationBarItem(
                    icon: CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.white,
                        child: IconButton(
                            onPressed: null,
                            icon: Icon(
                              Icons.add_task,
                              color: Colors.black,
                            ))),
                    label: '',
                    activeIcon: CircleAvatar(
                        radius: 25,
                        backgroundColor: Color.fromRGBO(139, 208, 252, 1),
                        child: IconButton(
                            onPressed: null,
                            icon: Icon(
                              Icons.add_task,
                              color: Colors.white,
                            )))),
              ],
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              selectedItemColor: Colors.white,
            ),
          ),
        ));
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
