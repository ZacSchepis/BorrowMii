import 'package:borrow_mii/core/errors/link_errors.dart';
import 'package:borrow_mii/router.dart';
import 'package:borrow_mii/widgets/nfc_scan.dart';
import 'package:flutter/material.dart';

class ItemScan extends StatefulWidget {
  const ItemScan({
    super.key, 
  
  });
  
  @override
  State<ItemScan> createState() => _ItemScanWidgetState();
}


class _ItemScanWidgetState extends State<ItemScan> {
  late final NfcScan _nfcWidget;
  bool scanned = false;
  Uri? appUri;
  @override
  void initState() {
    _nfcWidget = NfcScan(onScan: setScanned, setUri: onSetURI);

  }
  void setScanned() {
    setState(() {
      scanned = true;
    });
  }
  void onSetURI(Uri uri) {
    setState(() {
      appUri = uri;
    });
    try {
      AppRouter.handleLink(context, uri);

    } on LinkException catch(e) {
      print(e);
      Navigator.pop(context);
    }
  }
  @override
  void dispose() {
    super.dispose();
    
  }

  @override
  Widget build(BuildContext context) {
    
    return _nfcWidget;
  }
}