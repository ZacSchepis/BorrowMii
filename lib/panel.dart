import 'package:flutter/material.dart';
import 'package:team_d_project/modelViewController.dart';
import 'package:team_d_project/removableItem.dart';
import 'modelViewController.dart';
import 'item.dart';
import 'searchListWidget.dart';
import 'removableItem.dart';

//panels for tabbed info on main screen
class Panel extends StatefulWidget {
  const Panel({super.key});
  @override
  State<Panel> createState() => _PanelState();

}

class _PanelState extends State<Panel> {

  int _selectedIndex = 2;
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
  Widget displayWidget = Text("null");
  ModelViewController mvc = ModelViewController();

  List<Widget> getWidgetOptions() {
    return <Widget>[
      Expanded( child:
        Column(
          children: [
          const Text("My Items: "),
          Expanded(child: _MyDisplayWidget()),
          ],
        )
      ),
      Expanded(child: _BorrowPanel()),
      Expanded(child: _SearchPanel()),
    ];
  }



  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      displayWidget = getWidgetOptions().elementAt(index);
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          children: [
            displayWidget,
            //getWidgetOptions().elementAt(_selectedIndex),
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

abstract class _DisplayListWidget extends StatefulWidget{
  const _DisplayListWidget({super.key});
}

class _MyDisplayWidget extends _DisplayListWidget{
  const _MyDisplayWidget({super.key});

  @override
  _MyDisplayWidgetState createState() => _MyDisplayWidgetState();

}

class _BorDisplayWidget extends _DisplayListWidget{
  const _BorDisplayWidget({super.key});

  @override
  _BorDisplayWidgetState createState() => _BorDisplayWidgetState();
}



abstract class _DisplayListWidgetState extends State<_DisplayListWidget>{
  List<Item> items = [];
  ModelViewController mvc = ModelViewController();

  void getItems() async {
    //final newItems = await mvc.;
    setState(() {
      //items = newItems;
    });
  }

  @override void initState() {
    getItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

   return
     ListView.builder(
       itemCount: items.length,
       itemBuilder: (BuildContext context, int index) {
         return ListTile(
           title: items[index].build(context),
         );
       },
   );
  }

}

class _MyDisplayWidgetState extends _DisplayListWidgetState{

  @override
  void getItems() async {
    final newItems = await mvc.getMyItems();
    setState(() {
      items = newItems;
    });
  }
}

class _BorDisplayWidgetState extends _DisplayListWidgetState{

  @override
  void getItems() async {
    final newItems = await mvc.getBorrowedItems();
    setState(() {
      items = newItems;
    });
  }
}

class _SearchPanel extends StatefulWidget {

  @override
  _SearchPanelState createState() => _SearchPanelState();
}

class _SearchPanelState extends State<_SearchPanel> {
  List<Item> items = [];
  List<Item> filteredItems = [];
  ModelViewController mvc = ModelViewController();
  void filterSearchResults(String query) async{
    List<Item> results = [];
    items = await mvc.searchOtherItems();
    items.forEach((item) {
      if (item.itemname.toLowerCase().contains(query.toLowerCase())) {
        results.add(item);
      }
    });
    setState(() {
      filteredItems = results;
    });
  }

  Widget buildInteractable(int index) {
    return BorrowItem(filteredItems[index]).build(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Search for an item to borrow"),
        SizedBox(
          width: 200,
          child: TextField(
            onChanged: (query) {
              filterSearchResults(query);
            },
            decoration: const InputDecoration(
              hintText: 'Search',
            ),
          ),
        ),
        Expanded(child:
        ListView.builder(
          itemCount: filteredItems.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: buildInteractable(index),
            );
          },
        ),
        ),
      ],
    );
  }
}

class _BorrowPanel extends StatefulWidget {

  @override
  _BorrowPanelState createState() => _BorrowPanelState();
}

class _BorrowPanelState extends State<_BorrowPanel> {
  List<Item> items = [];
  List<Item> filteredItems = [];
  ModelViewController mvc = ModelViewController();
  void filterSearchResults(String query) async{
    List<Item> results = [];
    items = await mvc.searchOtherItems();
    items.forEach((item) {
      if (item.itemname.toLowerCase().contains(query.toLowerCase())) {
        results.add(item);
      }
    });
    setState(() {
      filteredItems = results;
    });
  }

  Widget buildInteractable(int index) {
    return ReturnItem(filteredItems[index]).build(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Search for an item to return"),
        SizedBox(
          width: 200,
          child: TextField(
            onChanged: (query) {
              filterSearchResults(query);
            },
            decoration: const InputDecoration(
              hintText: 'Search',
            ),
          ),
        ),
        Expanded(child:
        ListView.builder(
          itemCount: filteredItems.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: buildInteractable(index),
            );
          },
        ),
        ),
      ],
    );
  }
}
class BorrowItem extends RemovableItem{
  BorrowItem(Item item, {super.key}) : super(item);
  @override
  void _deleteItem(Item item){
    mvc.borrowItem(item);
  }
}

class ReturnItem extends RemovableItem{
  ReturnItem(Item item, {super.key}) : super(item);
  @override
  void _deleteItem(Item item){
    mvc.returnItem(item);
  }
}