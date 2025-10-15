
import 'package:borrow_mii/core/errors/item_errors.dart';

abstract class ChooseController<T> {
  String Function(T item) getLabel;  
  ChooseController({required this.getLabel});
  List<T> items = List.empty(growable: true);
  Map<String, List<int>> maps = {};


  // ChooseController();
  Set<int> indices = {};
  void setItems(List<T> item) {
    items = item;
    maps.clear();
    // items.addAll(item);
    for(int i = 0; i < items.length; i++) {
      addToGroup(getLabel(item[i]), i);
    }

    // item.forEach(addToGroup())
  }
  void updateItem(int i, T itm) {
    final originalItem = getItem(i);
    final prevGroup = getLabel(originalItem);
    final newGroup = getLabel(itm);
    if(prevGroup != newGroup) {
      _removeItemFromGroupViaIndex(i);
      addToGroup(newGroup, i);
      items[i] = itm;
    }
  }
  void pushIndex(int i) {
    if(!indices.contains(i)) {
      indices.add(i);
    } else {
      indices.remove(i);
    }
  }
  void clearSelection() {
    indices.clear();
  }
  T getItem(int index) {
    if(items.isEmpty || index >= items.length || index < 0) throw Exception("Index out of bounds");
    return items[index];
  }
  int _removeItemFromGroupViaIndex(int index) {
    int res = -1;
    maps.forEach((k, v) {
      final entry = v.indexOf(index);
      if(entry != -1) {
        v.removeAt(entry);
        res = 0;
      }
    });
    return res;
  }
  void addToGroup(String k, int index) {
    // Add it if it doesnt exist yet. 
    final group = k.isEmpty ? "Uncategorized" : k;
    var ent = maps.putIfAbsent(group, () => List.empty(growable: true));
    ent.add(index);
  }

}

class SimpleChooser<T> extends ChooseController<T> {
  
  SimpleChooser({required super.getLabel});
}
