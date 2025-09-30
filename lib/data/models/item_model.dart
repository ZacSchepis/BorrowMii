import 'package:borrow_mii/core/constants/item_status.dart';
import 'package:borrow_mii/data/models/borrow_terms.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ItemModel {


  // Owner info
  String owner = "";
  String ownerId = "";

  // Item info
  // String? status = "";
  String? name = "";
  String? description = "";
  String? condition = "";
  String? image = "";
  String? serial = "";
  String? link = "";
  int? retail = 0;
  int? value = 0;
  bool? dailyFeeEnabled = false;
  bool? flatFeeEnabled = false;
  bool amIBorrowingThis;
  String id = "";
  int? lateFeeDays = 0;
  int? flatFeeMonths = 0;
  int? lateFeeCost = 0;
  int? flatFeeCost = 0;
  ItemStatus? status = ItemStatus.home;
  String? borrowerId;
  BorrowTerms? terms;
  ItemModel({
    required this.owner,
    required this.ownerId,
    required this.id,
    this.status,
    this.name,
    this.description,
    this.condition,
    this.flatFeeEnabled,
    this.dailyFeeEnabled,
    this.image,
    this.serial,
    this.link,
    this.retail,
    this.value,
    this.terms,
    this.borrowerId = "",
    this.amIBorrowingThis = false,
    // Cost related
    this.lateFeeCost,
    this.lateFeeDays,
    this.flatFeeCost,
    this.flatFeeMonths,

  });

  factory ItemModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      String currentUserId
      ) {
    final data = snapshot.data();
    print(data);
    var res = ItemModel(
      owner: data?["owner"],
      ownerId: data?["ownerId"],
      status: ItemStatus.values.byName(data?["status"] ?? "home"),
      name: data?["name"],
      description: data?["description"],
      condition: data?["condition"],
      image: data?["image"],
      serial: data?["serial"],
      link: data?["link"],
      id: data?["id"],
      retail: data?["retail"] ?? 0,
      value: data?["value"] ?? 0,
      terms: BorrowTerms.fromMap(data),
      flatFeeEnabled: data?["flatFeeEnabled"],
      dailyFeeEnabled: data?["dailyFeeEnabled"],
      lateFeeDays: data?["lateFeeDays"],
      flatFeeMonths: data?["flatFeeMonths"],
      lateFeeCost: data?["lateFeeCost"],
      flatFeeCost: data?["flatFeeCost"],
      borrowerId: data?["borrowerId"],
      
    );
    res.amIBorrowingThis = res.borrowerId == currentUserId;
    return res;
  }
  Map<String, dynamic> toFirestore() {
    return {
      'owner': owner,
      'ownerId': ownerId,
      'id': id,
      if(terms != null) 'terms': terms?.toMap(),
      if(status != null) 'status': status.toString(),
      if(name != null) 'name': name,
      if(description != null) 'description': description,
      if(condition != null) 'condition': condition,
      if(flatFeeEnabled != null) 'flatFeeEnabled': flatFeeEnabled,
      if(dailyFeeEnabled != null) 'dailyFeeEnabled': dailyFeeEnabled,
      if(image != null) 'image': image,
      if(serial != null) 'serial': serial,
      if(link != null) 'link': link,
      if(retail != null) 'retail': retail,
      if(value != null) 'value': value,
      if(lateFeeCost != null) 'lateFeeCost': lateFeeCost,
      if(lateFeeDays != null) 'lateFeeDays': lateFeeDays,
      if(flatFeeCost != null) 'flatFeeCost': flatFeeCost,
      if(flatFeeMonths != null) 'flatFeeMonths': flatFeeMonths,
      if(borrowerId != null) 'borrowerId': borrowerId
    };
  }

  static ItemModel generate(int idx) {
    return ItemModel(
      owner: "Owner$idx",
      ownerId: "TESTER",
      status: ItemStatus.home,
      name: "ItemName",
      description: "ItemDescription",
      image: "<>",
      serial: "ItemSerial",
      link: "https://youtu.be/dQw4w9WgXcQ",
      condition: "Good",
      id: "TEST123",
      retail: 0,
      value: 0,
      flatFeeEnabled: false,
      dailyFeeEnabled: false
    );
  }

  Widget build(BuildContext context) {
    return Container(
    padding: const EdgeInsets.all(8), // optional
    decoration: BoxDecoration(
      color: amIBorrowingThis ? Colors.purple : Colors.blue, // background color
      borderRadius: BorderRadius.circular(8), // optional rounded corners
    ),
    child: Row(
      children: [
        Icon(
          Icons.gavel,
          color: Colors.black,
          size: 24,
          semanticLabel: name,
        ),
        const SizedBox(width: 8), // cleaner than Text("    ")
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Item: $name"),
            Text("Owner: $owner"),
            Text("Status: $status"),
          ],
        ),
      ],
    ),
  );
  }
}
