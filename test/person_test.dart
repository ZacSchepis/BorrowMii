import 'package:team_d_project/person.dart';
import 'package:team_d_project/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Username test', () {
    Person person = Person('ADMIN', "ADMIN");

    expect(person.uname, 'ADMIN');
  });

  test('Password test', () {
    Person person = Person('ADMIN', "ADMIN");

    expect(person.password, 'ADMIN');
  });

  test('addItem test', () {
    Person person = Person('ADMIN', 'ADMIN');
    Item item = Item('hammer', 'ADMIN', 'Available');
    person.addItem(item);
    expect(person.myItems, [
      {'itemName': 'hammer', 'owner': 'ADMIN', 'status': 'Available'}
    ]);
  });

  test('removeItemFromName test', () {
    Person person = Person('ADMIN', 'ADMIN');
    Item item = Item('hammer', 'bilbob', 'Available');
    person.addItem(item);
    person.removeItemFromName('hammer');
    expect(person.myItems, []);
  });

  test('removeItem test', () {
    Person person = Person('ADMIN', 'ADMIN');
    Item item = Item('hammer', 'ADMIN', 'Available');
    person.addItem(item);
    person.removeItem(item);
    expect(person.myItems, []);
  });

  test('borrowItem test', () {
    Person person = Person('ADMIN', 'ADMIN');
    Item item = Item('hammer', 'bilbob', 'Available');
    person.borrowAItem(item);
    expect(person.bItems, [
      {'itemName': 'hammer', 'owner': 'bilbob', 'status': 'Borrowed'}
    ]);
  });

  test('returnItem test', () {
    Person person = Person('ADMIN', 'ADMIN');
    Item item = Item('hammer', 'bilbob', 'Available');
    person.borrowAItem(item);
    person.returnItem(item);
    expect(person.bItems, []);
  });

  test('addFriend test', () {
    Person person = Person('ADMIN', 'ADMIN');
    Person friend = Person('bilbob', '1234');
    person.addFriend(friend);
    expect(person.friends, [
      {'name': '', 'userName': 'bilbob'}
    ]);
  });

  test('addFriendByString test', () {
    Person person = Person('ADMIN', 'ADMIN');
    person.addFriendByString('bilbob');
    expect(person.friends, ['bilbob']);
  });

  test('removeFriend test', () {
    Person person = Person('ADMIN', 'ADMIN');
    Person friend = Person('bilbob', '1234');
    person.addFriend(friend);
    person.removeFriend(friend);
    expect(person.friends, []);
  });

  test('removeFriendByString test', () {
    Person person = Person('ADMIN', 'ADMIN');
    person.addFriendByString('bilbob');
    person.removeFriendByString('bilbob');
    expect(person.friends, []);
  });
}
