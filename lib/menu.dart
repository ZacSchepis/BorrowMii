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
import 'searchListWidget.dart';

//menu for editing profile features
class Menu extends StatelessWidget {
  //constructor
  Menu({super.key});
  //variables
  ModelViewController mvc = ModelViewController();

  SearchListWidget searchListWidget = SearchListWidget();

  final leftController = TextEditingController();
  final rightController = TextEditingController();

  //StatefulWidget displaySearch;

  //StatefulWidget results = [];

  //methods

  // StatefulWidget buildSearchResults(BuildContext context, String search) {
  //   List<Widget> widgetListItems = [const Text("Items:")];
  //   StatefulWidget widget;
  //
  //   // Person testFriend = Person("bilbob", "1234");
  //   // removeFriend(testFriend);
  //
  //   ModelViewController().searchMyItems(search).forEach((element) {
  //     RemovableItem rItem = RemovableItem(element);
  //     widgetListItems.add(rItem.build(context));
  //   });
  //
  //   widget = Column(
  //     children: widgetListItems
  //   ) as StatefulWidget;
  //
  //   return widget;
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
      ),
      body: Container(
        child: Row(
          children: [
            //back button
            Column(
              children: [
                //title row
                Expanded(child:
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Text("Add"),
                      ),
                    ],
                  ),
                ),

                //row holding bottom
                Expanded( child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
                             SizedBox(
                                width: 200,
                                child:
                                  TextField(
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
                  ],
                ),
                ),
              ],
            ),
            Expanded(child: searchListWidget),
          ],
        ),
      ),
    );
  }
}

