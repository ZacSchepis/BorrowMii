import 'dart:io';

import 'package:borrow_mii/core/constants/image_mode.dart';
import 'package:borrow_mii/data/repositories/storage_repository.dart';
import 'package:borrow_mii/features/items/widgets/view_item/item_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:borrow_mii/data/models/item_model.dart';
import 'package:borrow_mii/widgets/button.dart';

class ImageModal extends StatefulWidget {
  final XFile? selectedImage;
  final ValueChanged<XFile?> onSelectImage;
  final Future<void> Function(ImageSource mode)? pickImage;
  final String imagePath;
  ImageModal(
      {super.key,
      required this.onSelectImage,
      required this.selectedImage,
      required this.pickImage,
      required this.imagePath});

  @override
  _ImageModalWidgetState createState() => _ImageModalWidgetState();
}

class _ImageModalWidgetState extends State<ImageModal> {
  @override
  Widget build(BuildContext ctx) {
    Widget imageWidget;
    if (widget.selectedImage != null) {
      imageWidget = Image.file(
        File(widget.selectedImage!.path),
        width: 250,
        height: 250,
        fit: BoxFit.cover,
      );
    } else if (widget.imagePath.isNotEmpty) {
      imageWidget = ItemImage(itemId: widget.imagePath);
    } else {
      imageWidget = Text(
        "No image selected",
        textAlign: TextAlign.center,
      );
    }
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // ItemImage(itemId: widget.imagePath),
          Text(
            "Upload image",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          // Text("()", textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold),),
          SizedBox(
            height: 250,
            width: 250,
            child: imageWidget,
          ),
          ElevatedButton(
              onPressed: () => widget.pickImage?.call(ImageSource.gallery),
              child: const Text("Select image")),
          ElevatedButton(
              onPressed: () => widget.pickImage?.call(ImageSource.camera),
              child: const Text("Open Camera")),
          // Spacer(),
          // Align(
          //   alignment: Alignment.bottomRight,
          //   child: ElevatedButton(onPressed: onNext, child: Text("Next")),
          // )
        ],
      ),
    );
  }
}
