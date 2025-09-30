import 'package:borrow_mii/core/styles/styles.dart';
import 'package:flutter/material.dart';

class LoadingModal extends StatefulWidget {
  final String title;
  final String subtitle;
  bool loaded;
  LoadingModal({
    super.key,
    this.subtitle = "",
    this.title = "",
    required this.loaded
  });

  @override
  State<LoadingModal> createState() => _LoadingScreenWidgetState();
}

class _LoadingScreenWidgetState extends State<LoadingModal> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.center,
          child: SizedBox(
            height: 250, width: 250,
            child: Column(
              children: [
                const CircularProgressIndicator(),
                if(widget.title.isNotEmpty) Text(widget.title, style: AppText.title,) ,
                if(widget.subtitle.isNotEmpty) Text(widget.subtitle, style: AppText.subtitle,)
              ],
            ),
          )
      ),
    );
  }
}