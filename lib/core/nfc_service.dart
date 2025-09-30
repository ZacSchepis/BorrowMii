// import 'package:nfc_manager/nfc_manager.dart';
import 'dart:convert';

import 'package:borrow_mii/core/constants/app_links.dart';
import 'package:borrow_mii/core/constants/nfc_messages.dart';
import 'package:borrow_mii/core/errors/nfc_errors.dart';
import 'package:nfc_manager/ndef_record.dart';
import 'package:nfc_manager/nfc_manager.dart';

import 'package:flutter/foundation.dart';
import 'package:nfc_manager/nfc_manager.dart';

import 'package:nfc_manager/nfc_manager_android.dart';
import 'package:nfc_manager/nfc_manager_ios.dart';

class NfcService {
  // final  onDiscovered;
  // const NfcService({required this.onDiscovered});
  late bool nfcAvailable;

  Future<bool> isAvailable() async {
    return NfcManager.instance.isAvailable();
  }
  Future<void> startSession(Function(NfcTag) onDiscovered) async {
    // final _inst = NfcManag/er.instance.
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
  Future<NdefMessage?> getNdefMessage(NfcTag tag) async{
    Future<NdefMessage?> ndefMsg;
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        final ndefA = NdefAndroid.from(tag);
        if(ndefA == null) throw NFCException(NfcMessages.incompatibleTag);
        ndefMsg = ndefA.getNdefMessage();
        break;
      case TargetPlatform.iOS:
        final ndefI = NdefIos.from(tag);
        if(ndefI == null) throw NFCException(NfcMessages.incompatibleTag);
        ndefMsg = ndefI.readNdef();
        break;
      default:
        throw NFCException(NfcMessages.notSupported);
    }
    return ndefMsg;
  }
  Future<Uri?> getNdef(NfcTag tag) async {
    final msg = await getNdefMessage(tag);
    if(msg == null) {
      throw NFCException(NfcMessages.unreadableCard);
    }
    for(final rec in msg.records) {
      final type = utf8.decode(rec.type);
      // String val = "";
      if(type == 'U') {
          final payload = rec.payload;
          if(payload.isEmpty) return null;
          final uriData = utf8.decode(payload.sublist(1));
          Uri? parsedUri = Uri.parse(uriData );
          if(parsedUri != null && parsedUri.scheme == APP_SCHEME) {
            return parsedUri;
          }
      }
      if (type == 'android.com:pkg') {
        // final pkgName = utf8.decode(rec.payload);
        // val = "Decoded AAR (Package Name): $pkgName";
      }
    }
    throw NFCException(NfcMessages.noValidData);
  }
  Future<void> stopSession() async {
    await NfcManager.instance.stopSession();
  }
}
