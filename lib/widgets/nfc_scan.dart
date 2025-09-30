import 'package:borrow_mii/core/constants/nfc_messages.dart';
import 'package:borrow_mii/core/errors/nfc_errors.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:borrow_mii/core/nfc_service.dart';

class NfcScan extends StatefulWidget {
  final VoidCallback onScan;
  final ValueChanged<Uri> setUri;
  const NfcScan({super.key, required this.onScan, required this.setUri});
  @override
  _NfcWidgetState createState() => _NfcWidgetState();
}

class _NfcWidgetState extends State<NfcScan> {
  final _nfcService = NfcService();
  String _tagData = "Waiting for NFC...";
  bool ready = false;
  String statusMessage = "Tap here to begin scanning";
  late bool available;
  bool clickable = true;

  Future<void> _checkNFCAvailability() async {
    try {
      final isAvailable = await _nfcService.isAvailable();
      if (!isAvailable) throw NFCException(NfcMessages.notSupported);
      available = isAvailable;
      return;
    } on PlatformException catch (e) {
      setToolTip(false, e.message);
      setState(() {
        clickable = false;
      });
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _checkNFCAvailability();
  }

  void setToolTip(bool r, String? msg) {
    setState(() {
      ready = r;
      statusMessage =
          msg ?? (ready ? "Ready to Scan" : "Tap here to begin scanning");
    });
  }

  void _startScanning() async {
    if (!clickable) return;
    setToolTip(!ready, null);
    try {
      _nfcService.startSession((NfcTag tag) async {
        final ndef = await _nfcService.getNdef(tag);
        final uri = ndef;
        if (uri != null) {
          widget.setUri(uri);
          setToolTip(true, "Reading...");
          widget.onScan();
          setToolTip(false, null);
        } else {
          throw NFCException("No tags were found.");
        }
      });
    } on NFCException catch (e) {
      setToolTip(false, e.message);
    } on PlatformException catch (e) {
      setToolTip(false, e.message);
    } catch (e) {
      setToolTip(false, "Unknown error occured");
    }
  }

  @override
  void dispose() {
    _nfcService.stopSession();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color iconColor =
        clickable ? (ready ? Colors.black : Colors.blueGrey) : Colors.red;
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(child: AbsorbPointer(
            absorbing: !clickable,
            child: InkWell(
                onTap: _startScanning,
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  color: Colors.orange[300],
                  child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     mainAxisSize: MainAxisSize.min,
                    children: [
                          Icon(
                            Icons.nfc,
                            color: iconColor,
                            size: 256,
                          ),
                          Text(
                            statusMessage,
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black),
                            textAlign: TextAlign.center,
                          ),

                    ],
                  ),
                ))),)

        );
  }
}
