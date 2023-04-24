import 'package:team_d_project/person.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Username test', () {
    Person cuser = Person('ADMIN', "ADMIN");

    expect(cuser.uname, 'ADMIN');
  });

  test('Password test', () {
    Person cuser = Person('ADMIN', "ADMIN");

    expect(cuser.password, 'ADMIN');
  });
}
