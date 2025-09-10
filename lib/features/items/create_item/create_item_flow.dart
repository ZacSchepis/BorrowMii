import 'package:borrow_mii/data/repositories/item_repository.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:borrow_mii/data/models/item_model.dart';
import 'package:borrow_mii/features/items/create_item/step1_image_upload.dart';
import 'package:borrow_mii/features/items/create_item/step2_item_details.dart';
import 'package:borrow_mii/features/items/create_item/step3_fees.dart';
import 'package:borrow_mii/widgets/nfc_scan.dart';

class CreateItemFlow extends StatefulWidget {
  final String id;
  const CreateItemFlow({super.key, required this.id});

  @override
  State<CreateItemFlow> createState() => _CreateItemFlowState();
}

class _CreateItemFlowState extends State<CreateItemFlow> {
  int _currentStep = 0;
  bool feesEnabled = false;
  ItemModel newItem = ItemModel.empty();
  XFile? image;
  String screenTitle = "";
  final ItemRepository _repo = ItemRepository();
  // bool scanned = false;
  // Uri? appUri;
  void nextStep() {
    if (_currentStep == 1 && !feesEnabled) {
      setState(() {
        _currentStep = 3;
        finish();
      });
    } 
    else {
      setState(() => _currentStep++);
    }
  }

  void setItemCondition(String? value) {
    setState(() => newItem.itemCondition = value!);
  }
  void finish() {
    newItem.itemId = widget.id;
    _repo.local.cacheItems([newItem]);
    Navigator.pop(context);
  }
  void previousStep() {
    setState(() => _currentStep = (_currentStep - 1).clamp(0, 3));
    if(_currentStep == 0) {
      finish();
    }
  }

  void setEnableFees(bool value) {
    setState(() => feesEnabled = value);
  }

  void setImage(XFile? img) {
    if(img != null) {
      setState(() {
        image = img;
      });
    }
  }
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setImage(pickedFile);
  }
  @override
  Widget build(BuildContext ctx) {
    Widget? currentScreen;
    switch (_currentStep) {
      case 0:
        currentScreen = Step1ImageUpload(
            item: newItem,
            onNext: nextStep,
            onSelectImage: setImage,
            pickImage: _pickImage,
            selectedImage: image);
        screenTitle = "Upload Item Image";
        break;
      case 1:

        currentScreen = Step2ItemDetails(
            onNext: nextStep,
            onChanged: setEnableFees,
            onConditionSet: setItemCondition,
            item: newItem,
            fees: feesEnabled);
        screenTitle = "Set Item Info";
        break;
      case 2:
        screenTitle = "Set Item Fees";
        currentScreen = Step3Fees(item: newItem, onNext: finish,);
        break;

      default:
        currentScreen = null;
        break;
    }

    return    
    Scaffold(
        appBar: AppBar(
          title: Text(screenTitle),
          leading: BackButton(onPressed: previousStep),
        ),
        body: Padding(
          
          padding: const EdgeInsets.fromLTRB(12.0, 8.0, 8.0, 8.0),
          child: Align(
            alignment: Alignment.topLeft,
            child:  currentScreen
            ,
          )
        )
        // alignment: Alignment.centerLeft,
        );
  }
}
