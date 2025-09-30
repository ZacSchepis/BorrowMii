import 'package:borrow_mii/core/constants/item_status.dart';
import 'package:borrow_mii/core/errors/item_errors.dart';
import 'package:borrow_mii/data/models/borrow_terms.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BorrowOrder {
  String? borrowerId;
  String itemId;
  String ownerId;
  String name;
  DateTime borrowDate;
  DateTime returnDate;
  BorrowTerms? terms;
  String? id;
  ItemStatus status;
  BorrowOrder({
    required this.borrowDate,
    this.borrowerId,
    required this.itemId,
    required this.name,
    required this.ownerId,
    required this.returnDate,
    this.terms,
    this.id,
    required this.status,
  });
  Map<String, dynamic> toFirestore() {
    // if(borrowerId == null) {
    //   throw BorrowerMissingException("You must be signed in to borrow this item!");
    // }
    // if()
    return {
      'borrowDate':borrowDate,
      'borrowerId':borrowerId,
      'itemId':itemId,
      'name':name,
      'ownerId':ownerId,
      'returnDate':returnDate,
      if(terms != null) 'terms':terms!.toMap(),
      'id': id,
      'status': status.name.toString(),
   };
  }
  static DateTime _parseDate(dynamic value) {
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    throw StateError("Invalid date type: $value");
  }
  factory BorrowOrder.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options
  ) {
    final data = snapshot.data();
    return BorrowOrder(
      borrowerId: data?["borrowerId"], 
      itemId: data?["itemId"], 
      name: data?["name"], 
      ownerId: data?["ownerId"], 
      returnDate: _parseDate(data?["returnDate"]), 
      borrowDate: _parseDate(data?["borrowDate"]), 
      id: data?["id"],
      terms: BorrowTerms.fromMap(data),
      status: ItemStatus.values.byName(data?["status"] ?? "pendingBorrow"),

    );
  }

}