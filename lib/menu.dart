import 'dart:js';
import 'package:flutter/material.dart';
import 'package:team_d_project/modelViewController.dart';
import 'item.dart';
import 'person.dart';
import 'databaseController.dart';
// import 'package:team_d_project/Providers/user_provider.dart';
// import 'package';
// import 'user_provider.dart';
import 'Notifiers/user_notifier.dart';
import 'current_user.dart';
import 'package:provider/provider.dart';

//menu for editing profile features
class Menu extends StatelessWidget {
  //constructor
  Menu({super.key});
  //variables
  ModelViewController mvc = ModelViewController();

  final leftController = TextEditingController();
  final rightController = TextEditingController();

  //add to update function
  String _search = "";

  //methods
  Widget buildSearchResults(BuildContext context, String search) {
    List<Widget> widgetListItems = [const Text("Items:")];
    Widget widget;

    // Person testFriend = Person("bilbob", "1234");
    // removeFriend(testFriend);

    ModelViewController().searchMyItems(search).forEach((element) {
      RemovableItem rItem = RemovableItem(element);
      widgetListItems.add(rItem.build(context));
    });
    
    widget = Column(
      children: widgetListItems
    );
    
    return widget;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
      ),
      body: Container(
        child: Column(
          children: [
            //back button
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Back'),
                ),
              ],
            ),

            //title row
            Row(
            crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text("Add"),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Text("Remove"),
                  ),
                ),
              ],
            ),
            //row holding bottom
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                  //column 1 (left side)
                  Expanded(
                    child:
                    Column(
                      children: [
                        //row with name and textfield
                        Row(
                          children: [
                            //name text
                            Container(
                              alignment: Alignment.center,
                              child: const Text("Name of item     "),
                            ),
                            //text field
                            Expanded(
                              child: TextField(
                                textInputAction: TextInputAction.go,
                                onSubmitted: (value) {
                                  mvc.addItemFromName(value);
                                  //print("added " + value);
                                  leftController.text = "";
                                },
                                controller: leftController,
                                autofocus: true,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                  ),

                //column 2 (right side)
                Expanded(
                    child: Column(
                      children: [
                        //Top row
                        Row(
                          children: [
                            //search label
                            Container(
                              alignment: Alignment.center,
                              child: const Text("Search     "),
                            ),
                            //search text box
                            Expanded(child: Container(
                              alignment: Alignment.center,
                              child: TextField(
                                controller: rightController,
                                autofocus: true,
                              ),
                            ),)

                          ],
                        ),
                        //column displaying search results
                        Column(
                          children: [
                            buildSearchResults(context, _search)
                          ],
                        ),
                      ],
                    ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RemovableItem{
  Item _item = Item("1","1","1");
  RemovableItem(Item item){
    _item = item;
  }
  Widget build(BuildContext context){
    return Row(
      children: [
        _item.build(context),
        ElevatedButton.icon(
            onPressed:(){
              //delete item from person class
              //create modelviewcontroller method to delete passing item
              //create method to delete item in person call passing method
            },
            icon: const Icon(
              Icons.clear,
              color: Colors.red,
              size: 40.0,
            ),
            label: const Text("remove")
        )
      ],
    );
  }
}