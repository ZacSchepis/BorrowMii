
import 'package:flutter/material.dart';
import 'package:team_d_project/data/models/item_model.dart';
import 'package:team_d_project/widgets/button.dart';

class Step1ImageUpload extends StatefulWidget{
  ItemModel item;
  final VoidCallback onNext;
  final FileImage? selectedImage;
  final VoidCallback onSelectImage;
  Step1ImageUpload({
    super.key,
    required this.item,
    required this.onNext,
    required this.onSelectImage,
    required this.selectedImage
  });

  @override
  _Step1ImageUploadWidgetState createState() => _Step1ImageUploadWidgetState(onNext: onNext);


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
        Container(color: Colors.grey.shade100, width: 100, height: 100,),
        Align(
          child: Button(text: "Next", onPressed: onNext),
          alignment: Alignment.bottomRight,
        )
      ],

    );
  }
}