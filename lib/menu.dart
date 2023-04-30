import 'package:flutter/material.dart';
import 'package:team_d_project/modelViewController.dart';
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

