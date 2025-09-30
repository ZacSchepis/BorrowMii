import 'dart:io';

import 'package:borrow_mii/data/repositories/storage_repository.dart';
import 'package:borrow_mii/features/items/widgets/view_item/item_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:borrow_mii/data/models/item_model.dart';
import 'package:borrow_mii/widgets/button.dart';

class Step1ImageUpload extends StatefulWidget {
  ItemModel item;
  final VoidCallback onNext;
  final XFile? selectedImage;
  final ValueChanged<XFile?> onSelectImage;
  final AsyncCallback pickImage;
  final String imagePath;
  Step1ImageUpload(
      {super.key,
      required this.item,
      required this.onNext,
      required this.onSelectImage,
      required this.selectedImage,
      required this.pickImage,
      required this.imagePath
      });

  @override
  _Step1ImageUploadWidgetState createState() =>
      _Step1ImageUploadWidgetState(onNext: onNext);
}

class _Step1ImageUploadWidgetState extends State<Step1ImageUpload> {
  // final ItemModel item;
  final VoidCallback onNext;
  _Step1ImageUploadWidgetState({
    required this.onNext,
  });
  @override
  Widget build(BuildContext ctx) {
    Widget imageWidget;
    if(widget.selectedImage != null){
      imageWidget = Image.file(File(widget.selectedImage!.path), width: 250, height: 250, fit:BoxFit.cover,);
    } else if (widget.imagePath.isNotEmpty) {
      imageWidget = ItemImage(itemId: widget.imagePath);
    } else {
      imageWidget = Text("No image selected");
    }
    return Column(
      children: [
        // ItemImage(itemId: widget.imagePath),
        SizedBox(height: 250, width: 250, child: imageWidget,),
                    ElevatedButton(
                  onPressed: widget.pickImage, child: const Text("Select image")),
        // Column(
        //   children: [
        //     widget.selectedImage == null
        //         ? Container(
        //           width: 250,
        //           height: 250,
        //           child: const Text("No image selected"),
        //         )
        //         : Image.network(widget.selectedImage!.path, width: 250, height: 250,),
        //     ElevatedButton(
        //           onPressed: widget.pickImage, child: const Text("Select image")),

        //         ],
        // ),
        Spacer(),
        Align(
          child: ElevatedButton(onPressed: onNext, child: Text("Next")),
          alignment: Alignment.bottomRight,
          
        )
      ],
    );
  }
}
