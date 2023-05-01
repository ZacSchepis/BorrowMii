// import 'package:team_d_project/person.dart';
// import 'package:team_d_project/item.dart';
// import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

void main() {
  // Process as shown at https://blog.victoreronmosele.com/mocking-firestore-flutter
  test('simple database write/get test', () async {
    final FakeFirebaseFirestore fakeFirebaseFirestore = FakeFirebaseFirestore();

    const String collectionPath = 'users';
    const String documentPath = 'username';

    const Map<String, dynamic> data = {'userName': documentPath};

    await fakeFirebaseFirestore
        .collection(collectionPath)
        .doc(documentPath)
        .set(data);

    final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await fakeFirebaseFirestore
            .collection(collectionPath)
            .doc(documentPath)
            .get();
    final Map<String, dynamic> actualData = documentSnapshot.data()!;

    expect(actualData, data);
  });
}
