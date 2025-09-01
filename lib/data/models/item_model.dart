import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ItemModel {
  String _owner = "";
  String _status = "";
  String _itemName = "";
  String _itemDesc = "";
  String _itemImg = "";
  String _itemSerial = "";
  String _itemLink = "";
  String _itemCondition = "";
  int _itemRetail = 0;
  int _itemValue = 0;
  bool _dailyFeeEnabled = false;
  bool _flatFeeEnabled = false;
  int _lateFeeDays = 0;
  int _flatFeeMonths = 0;
  int _lateFeeCost = 0;
  int _flatFeeCost = 0;
  ItemModel(
    String owner,
    String status,
    String itemName,
    String itemDesc,
    String itemImg,
    String itemSerial,
    String itemLink,
    String itemCondition,
    int itemRetail,
    int itemValue,
  ) {
    _owner = owner;
    _status = status;
    _itemName = itemName;
    _itemDesc = itemDesc;
    _itemImg = itemImg;
    _itemSerial = itemSerial;
    _itemLink = itemLink;
    _itemRetail = itemRetail;
    _itemValue = itemValue;
  }
  String get owner => _owner;
  String get status => _status; 
  String get itemName => _itemName; 
  String get itemDesc => _itemDesc; 
  String get itemImg => _itemImg; 
  String get itemSerial => _itemSerial; 
  String get itemLink => _itemLink; 
  String get itemCondition => _itemCondition;
  int get itemRetail => _itemRetail; 
  int get itemValue => _itemValue; 

  int get lateFeeDays => _lateFeeDays;
  int get flatFeeMonths => _flatFeeMonths;
  bool get dailyFeeEnabled => _dailyFeeEnabled;
  bool get flatFeeEnabled => _flatFeeEnabled;
  int get lateFeeCost => _lateFeeCost;
  int get flatFeeCost => _flatFeeCost;

  set lateFeeDays(int v) { _lateFeeDays = v;}
  set flatFeeMonths(int v) { _flatFeeMonths = v; }
  set dailyFeeEnabled(bool v) { _dailyFeeEnabled = v; }
  set flatFeeEnabled(bool v) { _flatFeeEnabled = v; }
  set flatFeeCost(int v) { _flatFeeCost = v; }
  set lateFeeCost(int v) { _lateFeeCost = v; }
  set owner(String value) { _owner = value.isEmpty ? _owner : value; }
  set status(String value) { _status = value.isEmpty ? _status : value; }
  set itemName(String value) { _itemName = value.isEmpty ? _itemName : value; }
  set itemDesc(String value) { _itemDesc = value.isEmpty ? _itemDesc : value; }
  set itemImg(String value) { _itemImg = value.isEmpty ? _itemImg : value; }
  set itemSerial(String value) { _itemSerial = value.isEmpty ? _itemSerial : value; }
  set itemLink(String value) { _itemLink = value.isEmpty ? _itemLink: value; }
  set itemValue(int value) { _itemValue = value;}
  set itemRetail(int value) { _itemRetail = value;}
  set itemCondition(String value) { _itemCondition = value; }
  static ItemModel empty() {
    return ItemModel("", "", "", "", "", "", "", "Good", 0, 0);
  }
  
  factory ItemModel.fromJson(Map<String, dynamic> json, String id) {
    return ItemModel(
      json["owner"] ?? '', 
      json["status"] ?? '', 
      json["itemName"] ?? '', 
      json["itemDesc"] ?? '', 
      json["itemImg"] ?? '', 
      json["itemSerial"] ?? '', 
      json["itemLink"] ?? '',
      json["itemCondition"] ?? '', 
      json["itemRetail"] ?? 0, 
      json["itemValue"] ?? 0,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'owner': _owner,
      'status': _status,
      'itemName': _itemName,
      'itemDesc': _itemDesc,
      'itemImg': _itemImg,
      'itemSerial': _itemSerial,
      'itemLink': _itemLink,
      'itemRetail': _itemRetail,
      'itemValue': _itemValue,
      'itemCondition': _itemCondition
    };
  }
  static ItemModel generate(int idx) {
    return ItemModel("Owner$idx", "Status", "ItemName", "ItemDesc", "<>", "ItemSerial", "https://youtu.be/dQw4w9WgXcq", "Good", 1, 1);
  }

  Widget build(BuildContext context) {
    return Row(children: [
      Icon(Icons.gavel, color: Colors.black, size: 24, semanticLabel: _itemName,), 
      const Text("    "),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Item: $_itemName"),
          Text("Owner: $_owner"),
          Text("Status: $_status")
        ],

      )
    ],);
  }
}