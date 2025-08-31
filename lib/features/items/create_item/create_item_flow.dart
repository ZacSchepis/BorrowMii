import 'package:flutter/material.dart';
import 'package:team_d_project/data/models/item_model.dart';
import 'package:team_d_project/features/items/create_item/step1_image_upload.dart';
import 'package:team_d_project/features/items/create_item/step2_item_details.dart';

class CreateItemFlow  extends StatefulWidget{
  const CreateItemFlow({super.key});

  @override
  State<CreateItemFlow> createState() => _CreateItemFlowState();
}

class _CreateItemFlowState extends State<CreateItemFlow> {
  int _currentStep = 0;
  bool feesEnabled = false;
  final ItemModel newItem = ItemModel.empty();
  FileImage? image;

  void nextStep() {
    if(_currentStep == 1 && !feesEnabled) {
      setState(() {
        _currentStep = 3;
      });
    } else {
      setState(() => _currentStep++);
    }
  }
  void setItemCondition(String? value) {
    setState(() => newItem.itemCondition = value!);
  }
  void previousStep() {
    setState(() => _currentStep = (_currentStep - 1).clamp(0, 3));
  }
  void setEnableFees(bool value){
    setState(() => feesEnabled = value);
  }
  void setImage(){}
  @override
  Widget build(BuildContext ctx) {
    Widget currentScreen;
    switch (_currentStep) {
      case 0:
        currentScreen = Step1ImageUpload(item: newItem, onNext: nextStep, onSelectImage: setImage, selectedImage: image);
        break;
      case 1:
        currentScreen = Step2ItemDetails(onNext: nextStep, onChanged: setEnableFees, onConditionSet: setItemCondition, item: newItem);
        break;
      default:
        currentScreen = Text("Idk");
    }
    
    return currentScreen;
  }
}
