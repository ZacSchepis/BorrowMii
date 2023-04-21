

import 'package:team_d_project/person.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Counter value should be incremented', () {
    Person person = Person('ADMIN', "ADMIN");

    expect(person.uname,'ADMIN');
  });
}