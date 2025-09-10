import 'package:flutter/material.dart';
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

  void _startScanning() async {
    _nfcService.startSession((NfcTag tag) async {
      final ndef = await _nfcService.getNdef(tag);
      setState(() {
        // print(ndef);
        final uri = ndef;
        if (uri != null) {
          widget.setUri(uri);
        }
        // Future.delayed(const Duration(seconds: 10));
        widget.onScan();
      });
    });
  }

  @override
  void dispose() {
    _nfcService.stopSession();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return Column(
    //   children: [
    //       FloatingActionButton(
    //     onPressed: _startScanning,
    //     child: Icon(Icons.nfc),
    //   )
    //   ],

    // );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        // appBar: AppBar(title: Text("NFC Scan")),
        // body: Center(child: Text(_tagData)),
        children: [
          const Text(
            "NFC Scan",
            style: const TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              onPressed: _startScanning,
              child: const Icon(Icons.nfc),
            ),
          )
        ]));
  }
}
