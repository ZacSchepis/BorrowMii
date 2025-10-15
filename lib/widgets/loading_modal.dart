import 'package:borrow_mii/core/styles/styles.dart';
import 'package:flutter/material.dart';

class LoadingModal extends StatefulWidget {
  final String title;
  final String subtitle;
  bool loaded;
  final double width, height;
  LoadingModal({
    super.key,
    this.subtitle = "",
    this.title = "",
    required this.loaded,
    this.width = 250, this.height =250
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
            height: widget.height, width: widget.width,
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