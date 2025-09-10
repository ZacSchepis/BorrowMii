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
  Step1ImageUpload(
      {super.key,
      required this.item,
      required this.onNext,
      required this.onSelectImage,
      required this.selectedImage,
      required this.pickImage});

  @override
  _Step1ImageUploadWidgetState createState() =>
      _Step1ImageUploadWidgetState(onNext: onNext);
}

class _Step1ImageUploadWidgetState extends State<Step1ImageUpload> {
  // final ItemModel item;
  final VoidCallback onNext;
  // final FileImage? selectedImage;
  // final VoidCallback onSelectImage;

  _Step1ImageUploadWidgetState({
    required this.onNext,
  });
  @override
  Widget build(BuildContext ctx) {
    return Column(
      children: [
        Column(
          children: [
            widget.selectedImage == null
                ? Container(
                  width: 250,
                  height: 250,
                  child: const Text("No image selected"),
                )
                : Image.network(widget.selectedImage!.path, width: 250, height: 250,),
            ElevatedButton(
                  onPressed: widget.pickImage, child: const Text("Select image")),

                ],
        ),
        Spacer(),
        Align(
          child: ElevatedButton(onPressed: onNext, child: Text("Next")),
          alignment: Alignment.bottomRight,
          
        )
      ],
    );
  }
}
