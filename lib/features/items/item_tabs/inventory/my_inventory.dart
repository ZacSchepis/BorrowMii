import 'package:borrow_mii/core/controllers/choose_controller.dart';
import 'package:borrow_mii/core/styles/styles.dart';
import 'package:borrow_mii/data/datasources/items/my_items_state.dart';
import 'package:borrow_mii/data/models/item_model.dart';
import 'package:borrow_mii/data/repositories/item_repository.dart';
import 'package:borrow_mii/features/items/create_item/create_item_flow.dart';
import 'package:borrow_mii/widgets/collapsible_group_list.dart';
import 'package:borrow_mii/widgets/form_control.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyInventory extends StatefulWidget {
  const MyInventory({super.key});

  @override
  State<MyInventory> createState() => _MyInventoryWidgetState();
}

class _MyInventoryWidgetState extends State<MyInventory> {
  SnackBar? snackError; 
  final SimpleChooser chooser = SimpleChooser<ItemModel>(
    getLabel: (item) => item.category,
  );
  ItemRepository repo = ItemRepository();

  @override
  void didChangeDependencies() {
    setItems();
    super.didChangeDependencies();
  }

  void setItems() {
    MyItemsState myItems = Provider.of<MyItemsState>(context, listen: false);
    chooser.setItems(myItems.items);
    // .then((r) => setState(() {
    //       chooser.setItems(r);
    //     }));
  }

  @override
  void initState() {
    super.initState();
    setItems();
  }

  Future<void> addSelectedItemsToGroup(String group) async {
    List<Future<void>> futures = List.empty(growable: true);
    setState(() {
      
    for(final entr in chooser.indices) {
      ItemModel itm = chooser.items[entr];
      itm.category = group;
      chooser.updateItem(entr, itm);
      futures.add(repo.updateItemAttr("category", group, itm.id));
    }
    });
    try {
      await Future.wait(futures);
      chooser.clearSelection();
      // setState(() {
      //   chooser.items = List.from(chooser.items);
      // });
    } catch (e) {
      print(e);
      if(!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Could not add items to group $group"),
        duration: Duration(seconds: 2),
      ));
    }
  }

  Future<String?> showGroupSelectionDialog(
    BuildContext context, List<String> options) async {
    final controller = TextEditingController();
    final res = await showDialog<String?>(
        context: context,
        builder: (context) {
          return SimpleDialog(
              title: Text(
                  "Add ${chooser.indices.length} items to group: (select 1)"),
              children: [
                ...options.map((o) {
                  return SimpleDialogOption(
                      child: Text(o),
                      onPressed: () => Navigator.pop(context, o));
                }),
                ExpansionTile(
                  title: Text("Create new group"),
                  children: [
                    FormControl(
                      label: "Group name",
                      controller: controller,
                    ),
                    IconButton(
                      onPressed: () => {
                        if(controller.text.isNotEmpty) {
                          Navigator.pop(context, controller.text.toString())
                        }
                      },
                      icon: Icon(Icons.done),
                      tooltip: "Add",
                    )
                  ],
                )
              ]);
        });
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My Items"),
          leading: BackButton(
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                final group = await showGroupSelectionDialog(context, chooser.maps.keys.toList());
                if(group != null && group.isNotEmpty) {
                  await addSelectedItemsToGroup(group);
                }
              },
              icon: Icon(Icons.playlist_add),
              tooltip: "Move selected items to a group",
            ),
            IconButton(
              onPressed: () => {},
              icon: Icon(Icons.edit),
              tooltip: "Edit selected item info",
            )
          ],
        ),
        
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                if (chooser.indices.isNotEmpty)
                  Text("Selecting: ${chooser.indices.length} items"),
                Expanded(
                    child: CollapsibleGroupList(
                      selectedTileColor: const Color.fromARGB(255, 113, 117, 144),
                      selectedColor: const Color.fromARGB(255, 225, 225, 225),
                      allowSelection: true,
                      onLongPress: (ItemModel item) => {Navigator.push(context, MaterialPageRoute(builder: (_) => CreateItemFlow(id: item.id, item: item,)))},
                        chooser: chooser,
                        getGroupKey: (ItemModel i) =>
                            i.category.isEmpty ? "Uncategorized" : i.category,
                        getLabel: (ItemModel i) => i.category.isEmpty
                            ? "uncategorized"
                            : i.category.toLowerCase().trim(),
                        buildTile: (ItemModel i, context) => i.build(context))),
              ],
            )));
  }
}
