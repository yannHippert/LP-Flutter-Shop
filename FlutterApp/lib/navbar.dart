import 'package:flutter/material.dart';
import 'package:flutter_sweater_shop/accoun_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  static const iconSize = 150.0;
  int _selectedIndex = 0;

  static const List _pages = [
    {
      "icon": Icons.list,
      "label": "Products",
      "widget": Icon(
        Icons.list,
        size: iconSize,
      ),
    },
    {
      "icon": Icons.search,
      "label": "Search",
      "widget": Icon(
        Icons.search,
        size: iconSize,
      ),
    },
    {
      "icon": Icons.account_circle,
      "label": "Account",
      "widget": AccounPage(),
    },
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<BottomNavigationBarItem> getNavIcons() {
    return _pages
        .map((e) =>
            BottomNavigationBarItem(icon: Icon(e["icon"]), label: e["label"]))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages.elementAt(_selectedIndex)["label"]),
      ),
      body: Center(
        child: _pages.elementAt(_selectedIndex)["widget"],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: getNavIcons(),
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
