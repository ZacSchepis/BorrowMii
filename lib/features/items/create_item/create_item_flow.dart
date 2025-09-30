import 'package:borrow_mii/data/datasources/user_datasource.dart';
import 'package:borrow_mii/data/repositories/item_repository.dart';
import 'package:borrow_mii/data/repositories/storage_repository.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:borrow_mii/data/models/item_model.dart';
import 'package:borrow_mii/features/items/create_item/step1_image_upload.dart';
import 'package:borrow_mii/features/items/create_item/step2_item_details.dart';
import 'package:borrow_mii/features/items/create_item/step3_fees.dart';
import 'package:borrow_mii/widgets/nfc_scan.dart';
import 'package:provider/provider.dart';

class CreateItemFlow extends StatefulWidget {
  final String id;
  const CreateItemFlow({
    super.key, 
    required this.id,
    });

  @override
  State<CreateItemFlow> createState() => _CreateItemFlowState();
}

class _CreateItemFlowState extends State<CreateItemFlow> {
  int _currentStep = 0;
  bool feesEnabled = false;
  late final ItemModel newItem;
  XFile? image;
  String screenTitle = "";
  final ItemRepository _repo = ItemRepository();
  final StorageRepository _storage = StorageRepository();
  bool itemCreated = false;
  String? imageDeleteMessage;
  // Uri? appUri;
  @override
  void initState() {
    super.initState();
    newItem = ItemModel(owner: "", id: widget.id, ownerId: "");
  }

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
    setState(() => newItem.condition = value!);
  }
  void finish() {
    newItem.id = widget.id;
    // if(_currentStep == 1)
    try {
      // if(_currentStep == 2 && !feesEnabled) {
        _repo.addItem(newItem, context);
        itemCreated = true;
      // }

    } catch (e) {
      itemCreated = false;
      return;
    }
    // _repo.local.cacheItems([newItem]);
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

  void setImage(XFile? img) async {
    if(img != null) {
      try {
        String? filePath = await _storage.uploadImage(img, context);
        if(filePath != null) {
          setState(() {
            newItem.image = filePath;
          });
        }
      } on FirebaseException catch (e) {
        return;
      } catch (e) {
        return;
      }
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
  Future<void> dispose() async {
    final hasImage = newItem.image;
    if(hasImage == null) return;
    if(itemCreated && hasImage.isNotEmpty) {
      imageDeleteMessage = await _storage.deleteImage(hasImage);
    }
    super.dispose();
  }
  @override
  Widget build(BuildContext ctx) {
    Widget? currentScreen;
    final user = ctx.read<UserState>();
    final userid = user.getUserID();
    final username= user.userName;
    switch (_currentStep) {
      case 0:
        currentScreen = Step1ImageUpload(
            item: newItem,
            onNext: nextStep,
            onSelectImage: setImage,
            pickImage: _pickImage,
            imagePath: newItem.image ?? "",
            selectedImage: image);
        screenTitle = "Upload Item Image";
        if(userid != null) {
          newItem.ownerId = userid;
        }
        if(username != null) {
          newItem.owner = username;
        }
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
