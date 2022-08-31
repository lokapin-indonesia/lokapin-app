import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

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
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Map',
      style: optionStyle,
    ),
    Text(
      'Index 2: Search',
      style: optionStyle,
    ),
    Text(
      'Index 3: Calendar',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.white,
                child: IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.home,
                      color: Colors.black,
                    ))),
            label: '',
            activeIcon: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.blue,
                child: IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.home,
                      color: Colors.white,
                    )))),
        BottomNavigationBarItem(
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
                backgroundColor: Colors.blue,
                child: IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.map,
                      color: Colors.white,
                    )))),
        BottomNavigationBarItem(
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
                backgroundColor: Colors.blue,
                child: IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.location_searching,
                      color: Colors.white,
                    )))),
          BottomNavigationBarItem(
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
                backgroundColor: Colors.blue,
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
      // backgroundColor: Colors.white,
      showSelectedLabels: false,
      showUnselectedLabels: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
