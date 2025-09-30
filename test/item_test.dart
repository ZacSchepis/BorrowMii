import 'package:borrow_mii/person.dart';
import 'package:borrow_mii/item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('getOwner test', () {
    Item testitem = Item('hammer', 'admin', 'Available');

    expect(testitem.getOwner(), 'admin');
  });

  test('getStatus test', () {
    Item testitem = Item('hammer', 'admin', 'Available');

    expect(testitem.getStatus(), 'Available');
  });

  test('setStatus test', () {
    Item testitem = Item('hammer', 'admin', 'Available');
    testitem.setStatus("Borrowed");
    expect(testitem.getStatus(), 'Borrowed');
  });
}
