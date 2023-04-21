import 'dart:js';

import 'package:flutter/material.dart';
import 'package:team_d_project/modelViewController.dart';
import 'modelViewController.dart';
import 'item.dart';

//panels for tabbed info on main screen
class Panel extends StatefulWidget {
  const Panel({super.key});
  @override
  State<Panel> createState() => _PanelState();
}

class _PanelState extends State<Panel> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  final Widget _myWid = const Text(
    'My Items',
    style: optionStyle,
  );
  final Widget _borWid = const Text(
    'Borrowed Items',
    style: optionStyle,
  );
  final Widget _searchWid = const Text(
    'Search Items',
    style: optionStyle,
  );
  final List<Widget> _myItems = [];
  final List<Widget> _borrowedItems = [];
  final List<Widget> _searchItems = [];

  ModelViewController mvc = ModelViewController();

  List<Widget> getWidgetOptions() {
    return <Widget>[
      Column(
        children: _myItems,
      ),
      Column(
        children: _borrowedItems,
      ),
      Column(
        children: _searchItems,
      ),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    updateLists();
  }

  void updateLists() async {
    print("in updateLists");
    _myItems.clear();
    _borrowedItems.clear();
    _searchItems.clear();
    List<Item> tempMy = await mvc.getMyItems();
    print("my items:");
    print(tempMy); // prints from database doesn't display though
    List<Item> tempBor = await mvc.getBorrowedItems();
    print("borrowed items:");
    print(tempBor); // prints from database doesn't display though
    for (Item i in tempMy) {
      _myItems.add(_myWid);
      _myItems.add(i.build(this.context));
    }
    for (Item i in tempBor) {
      _borrowedItems.add(_borWid);
      _borrowedItems.add(i.build(this.context));
    }
    _searchItems.add(_searchWid);
  }

  @override
  Widget build(BuildContext context) {
    updateLists();
    return Scaffold(
      body: Column(children: [
        getWidgetOptions().elementAt(_selectedIndex),
      ]),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'My Items',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Borrowed Items',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Find Items',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
