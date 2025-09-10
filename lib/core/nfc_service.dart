// import 'package:nfc_manager/nfc_manager.dart';
import 'dart:convert';

import 'package:borrow_mii/core/constants/app_links.dart';
import 'package:borrow_mii/router.dart';
import 'package:flutter/material.dart';
import 'package:nfc_manager/ndef_record.dart';
import 'package:nfc_manager/nfc_manager.dart';

import 'package:flutter/foundation.dart';
import 'package:nfc_manager/nfc_manager_android.dart';
import 'package:borrow_mii/widgets/nfc_scan.dart';
import 'package:nfc_manager/nfc_manager.dart';

class NfcService {
  // final  onDiscovered;
  // const NfcService({required this.onDiscovered});
  Future<void> startSession(Function(NfcTag) onDiscovered) async {
    await NfcManager.instance.startSession(
        pollingOptions: {NfcPollingOption.iso14443},
        onDiscovered: (tag) async {
          try {
            await onDiscovered(tag);
          } catch (e) {
            print("Error handling NFC tag: $e");
          } finally {
            NfcManager.instance.stopSession();
          }
        });
  }
  Future<Uri?> getNdef(NfcTag tag) async {
    // final nd = 
    final ndef = NdefAndroid.from(tag);
    if(ndef == null) {
      print("tag is not compatible with NDEF");
      return null;
    }
    final msg = await ndef.getNdefMessage();
    if(msg == null) {
      print("Could not read NDEF");
      return null;
    }
    // List<String> msgs = new List.empty(growable: true);
    for(final rec in msg.records) {
      final type = utf8.decode(rec.type);
      
      String val = "";
      print(rec.payload);
      print("Type: ${rec.type}");
      if(type == 'U') {
          final payload = rec.payload;
          if(payload.isEmpty) return null;

          final prefixCode = payload.first;
          final uriData = utf8.decode(payload.sublist(1));

          print(uriData);


        // final uriString = utf8.decode(uri);
        // print("Okay? $uriString");
        // try {
          Uri? parsedUri = Uri.parse(uriData );
          if(parsedUri != null && parsedUri.scheme == APP_SCHEME) {
            return parsedUri;
          }

        // } on FormatException catch(e) {
        //   print("Some wrong formatting: $e");
        // }
        // print("Decoded URI: $uriString");
        // val = "Decoded URI: $uriString";
        // return parsedUri;

        // msgs.add("Decoded URI: $uriString");
      }
      if (type == 'android.com:pkg') {
        final pkgName = utf8.decode(rec.payload);
        val = "Decoded AAR (Package Name): $pkgName";
        print("Decoded AAR (Package Name): $pkgName");
      }
      // else if(type == 'T') {
      //   final text = utf8.decode(rec.payload);
      //   val = "Text: $text";
      //   print("Text: $text");
      // } else {
      //   val = "unknown rec type: $type, payload: ${rec.payload}";
      //   print("unknown rec type: $type, payload: ${rec.payload}");
      // }
      // msgs.add(val);
    }
    // print(msg.);
    return null;
    // final res = msgs.join('\n');
    // return res;
  }
  Future<void> stopSession() async {
    await NfcManager.instance.stopSession();
  }
}
