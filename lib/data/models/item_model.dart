import 'package:borrow_mii/core/constants/item_status.dart';
import 'package:borrow_mii/data/models/borrow_terms.dart';
import 'package:borrow_mii/features/items/widgets/view_item/item_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ItemModel {
  // Owner info
  String owner;
  String ownerId;

  // Item info
  // String? status;
  String name;
  String description;
  String condition;
  String image;
  String serial;
  String link;
  int retail;
  int value;
  bool dailyFeeEnabled = false;
  bool flatFeeEnabled = false;
  bool amIBorrowingThis;
  String id;
  int lateFeeDays;
  int flatFeeMonths;
  int lateFeeCost;
  int flatFeeCost;
  ItemStatus status;
  String borrowerId;
  BorrowTerms? terms;
  String category;
  ItemModel({
    required this.owner,
    required this.ownerId,
    required this.id,
    this.status = ItemStatus.home,
    this.name = "(No Name)",
    this.description = "",
    this.condition = "used",
    this.flatFeeEnabled = false,
    this.dailyFeeEnabled = false,
    this.image = "",
    this.serial = "",
    this.link = "",
    this.retail = 0,
    this.value = 0,
    this.terms,
    this.borrowerId = "",
    this.amIBorrowingThis = false,
    // Cost related
    this.lateFeeCost = 0,
    this.lateFeeDays = 0,
    this.flatFeeCost = 0,
    this.flatFeeMonths = 0,
    this.category = "",
  });

  factory ItemModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      String currentUserId) {
    final data = snapshot.data();
    var res = ItemModel(
        owner: data?["owner"],
        ownerId: data?["ownerId"],
        status: ItemStatus.values.byName(data?["status"] ?? "home"),
        name: data?["name"] ?? "",
        description: data?["description"] ?? "",
        condition: data?["condition"] ?? "",
        image: data?["image"] ?? "",
        serial: data?["serial"] ?? "",
        link: data?["link"] ?? "",
        id: data?["id"],
        retail: data?["retail"] ?? 0,
        value: data?["value"] ?? 0,
        terms: BorrowTerms.fromMap(data),
        flatFeeEnabled: data?["flatFeeEnabled"] ?? false,
        dailyFeeEnabled: data?["dailyFeeEnabled"] ?? false,
        lateFeeDays: data?["lateFeeDays"] ?? 0,
        flatFeeMonths: data?["flatFeeMonths"] ?? 0,
        lateFeeCost: data?["lateFeeCost"] ?? 0,
        flatFeeCost: data?["flatFeeCost"] ?? 0,
        borrowerId: data?["borrowerId"] ?? "",
        category: data?["category"] ?? "none");
    res.amIBorrowingThis = res.borrowerId == currentUserId;
    return res;
  }
  Map<String, dynamic> toFirestore() {
    return {
      'owner': owner,
      'ownerId': ownerId,
      'id': id,
      if (terms != null) 'terms': terms?.toMap(),
      if (status != null) 'status': status.name.toString(),
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (condition != null) 'condition': condition,
      if (flatFeeEnabled != null) 'flatFeeEnabled': flatFeeEnabled,
      if (dailyFeeEnabled != null) 'dailyFeeEnabled': dailyFeeEnabled,
      if (image != null) 'image': image,
      if (serial != null) 'serial': serial,
      if (link != null) 'link': link,
      if (retail != null) 'retail': retail,
      if (value != null) 'value': value,
      if (lateFeeCost != null) 'lateFeeCost': lateFeeCost,
      if (lateFeeDays != null) 'lateFeeDays': lateFeeDays,
      if (flatFeeCost != null) 'flatFeeCost': flatFeeCost,
      if (flatFeeMonths != null) 'flatFeeMonths': flatFeeMonths,
      if (borrowerId != null) 'borrowerId': borrowerId,
      if (category != null) 'category': category
    };
  }

  static ItemModel generate(int idx) {
    return ItemModel(
        owner: "Owner$idx",
        ownerId: "TESTER",
        status: ItemStatus.home,
        borrowerId: "Borrower$idx",
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
        dailyFeeEnabled: false);
  }

  Widget build(BuildContext context) {
    return Row(
      children: [
        ItemImage(
          itemId: image ?? "",
          width: 50,
          height: 50,
          isGCSImage: true,
        ),
        const SizedBox(width: 8), // cleaner than Text("    ")
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Item: $name"),
            Text("Owner: $owner"),
            Text("Status: ${status.name}"),
            borrowerId.isNotEmpty
                ? Text(
                    "Borrower: $borrowerId",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  )
                : SizedBox()
          ],
        )),
      ],
    );
  }
}
