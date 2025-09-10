import 'package:borrow_mii/features/items/view_item/item_scan.dart';
import 'package:flutter/material.dart';
import 'package:borrow_mii/features/items/screens/my_items_screen.dart';
import 'package:borrow_mii/modelViewController.dart';
import 'package:borrow_mii/InteractableItem.dart';
import 'modelViewController.dart';
import 'item.dart';
import 'searchListWidget.dart';

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
  final Widget _scanWid = const Text(
    'Scan Item',
    style: optionStyle,
  );
  Widget displayWidget = const Text("");
  ModelViewController mvc = ModelViewController();

  List<Widget> getWidgetOptions() {
    return <Widget>[
      Expanded(
          child: Column(
        children: const [
          Text("My Items: "),
          Expanded(child: MyItemsScreenWidget()),
        ],
      )),
      Expanded(child: _BorrowPanel()),
      Expanded(child: _SearchPanel()),
      Expanded(child: ItemScan())
      // Expanded(child: _)
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
      body: Column(children: [
        displayWidget,
      ]),
      
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // add this line

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
          BottomNavigationBarItem(icon: Icon(Icons.nfc), label: "Scan Item")
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

abstract class _DisplayListWidget extends StatefulWidget {
  const _DisplayListWidget({super.key});
}

class _MyDisplayWidget extends _DisplayListWidget {
  const _MyDisplayWidget({super.key});

  @override
  _MyDisplayWidgetState createState() => _MyDisplayWidgetState();
}

abstract class _DisplayListWidgetState extends State<_DisplayListWidget> {
  List<Item> items = [];
  ModelViewController mvc = ModelViewController();

  void getItems() async {
    setState(() {});
  }

  @override
  void initState() {
    getItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: items[index].build(context),
        );
      },
    );
  }
}

class _MyDisplayWidgetState extends _DisplayListWidgetState {
  @override
  void getItems() async {
    final newItems = await mvc.getMyItems();
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
  void filterSearchResults(String query) async {
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
    BorrowItem bi = BorrowItem(filteredItems[index]);
    bi.setIcon(const Icon(
      Icons.add_circle,
      color: Colors.green,
      size: 40.0,
    ));
    bi.setText("Borrow");
    return bi.build(context);
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
        Expanded(
          child: ListView.builder(
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
  void filterSearchResults(String query) async {
    List<Item> results = [];
    items = await mvc.getBorrowedItems();
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
    ReturnItem ri = ReturnItem(filteredItems[index]);
    ri.setIcon(const Icon(
      Icons.remove_circle,
      color: Colors.yellow,
      size: 40.0,
    ));
    ri.setText("Return");
    return ri.build(context);
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
        Expanded(
          child: ListView.builder(
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

class BorrowItem extends InteractableItem {
  BorrowItem(Item item, {super.key}) : super(item);
  @override
  void interact(Item item) {
    mvc.borrowItem(item);
  }
}

class ReturnItem extends InteractableItem {
  ReturnItem(Item item, {super.key}) : super(item);
  @override
  void interact(Item item) {
    mvc.returnItem(item);
  }
}
