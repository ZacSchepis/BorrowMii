import 'item.dart';

class Person {
  String _name = "";
  String _dob = "";
  List<Item> myItems = <Item>[];
  List<Item> borrowedItems = <Item>[];
  List<Item> requestedItems = <Item>[];
  List<Person> friends = <Person>[];

  Person(String name, String dob) {
    _name = name;
    _dob = dob;
  }

  String get name => _name;
  // String getName() {
  //   return _name;
  // }

  // String getDOB() {
  //   return _dob;
  // }

  // List<Item> getMyItems() {
  //   // find out how to also display status of items
  //   return myItems;
  // }

  // List<Item> getBorrowedItems() {
  //   return borrowedItems;
  // }

  // List<Item> getRequestedItems() {
  //   return requestedItems;
  // }

  // // Add friend when button selected to become friends

  // // see friend list

  void addItem(Item item) {
    // when item is added just push button to add it set owner to current user and prompt user name tool
    item.setStatus("Available");
    myItems.add(item);
  }

  void removeItem(Item item) {
    int index = myItems.indexOf(item);
    myItems.remove(index);
  }

  void borrowItem(Item item) {
    if (item.getStatus() == "Available") {
      item.setStatus("Borrowed");
      borrowedItems.add(item);
    }
  }

  void returnItem(Item item) {
    item.setStatus("Available");
    int index = myItems.indexOf(item);
    borrowedItems.remove(index);
  }

  // void requestItem(Item item) {
  //   if (item.getStatus() == "Available") {
  //     item.setStatus("Requested");
  //   }
  // }

  // void acceptRequests(Item item) {
  //   if (item.getStatus() == "Requested") {
  //     item.setStatus("Borrowed");
  //     borrowedItems.add(item);
  //   }
  // }
}
