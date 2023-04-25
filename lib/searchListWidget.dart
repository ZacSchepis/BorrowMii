import 'package:flutter/material.dart';
import 'item.dart';
import 'modelViewController.dart';
import 'InteractableItem.dart';

class SearchListWidget extends StatefulWidget {
  const SearchListWidget({super.key});

  @override
  SearchListWidgetState createState() => SearchListWidgetState();
}

class SearchListWidgetState extends State<SearchListWidget> {
  List<Item> items = [];
  List<Item> filteredItems = [];
  ModelViewController mvc = ModelViewController();
  void filterSearchResults(String query) async{
    List<Item> results = [];
    items = await mvc.getMyItems();
    items.forEach((item) {
      if (item.itemname.toLowerCase().contains(query.toLowerCase())) {
        results.add(item);
      }
    });
    setState(() {
      filteredItems = results;
    });
  }

  Widget buildRemoveable(int index) {
    return RemovableItem(filteredItems[index]).build(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Search for an item to remove"),
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
              title: buildRemoveable(index),
            );
          },
        ),
        ),
      ],
    );
  }
}

class RemovableItem extends InteractableItem{
  RemovableItem(super.item, {super.key});
  @override
  void _interact(Item item){
    mvc.deleteItem(item);
  }
}