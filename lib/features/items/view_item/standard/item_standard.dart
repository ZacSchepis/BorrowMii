import 'package:app_links/app_links.dart';
import 'package:borrow_mii/core/controllers/stepper_controller.dart';
import 'package:borrow_mii/data/datasources/app_linkstate_datasource.dart';
import 'package:borrow_mii/features/items/view_item/standard/item_standard_view.dart';
import 'package:borrow_mii/features/items/view_item/standard/step1_borrow_item.dart';
// import 'package:borrow_mii/main.dart';
import 'package:borrow_mii/widgets/skeletons/item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ItemStandard extends ItemEntityViewModel {
  final VoidCallback goHome;
  const ItemStandard({super.key, required super.item, required this.goHome});

  @override
  State<ItemStandard> createState() => _ItemStandardWidgetState();
}

class _ItemStandardWidgetState extends State<ItemStandard> {
  late final StepperController _bigStepper;
  // String _title = "";
  
  // late final AppLinkState linkState;
  @override
  void initState(){
    super.initState();
    _bigStepper = StepperController(maxSteps: 2, onBackAtFirstStep: returnHome, onStepChanged: () => setState(() {}));
    // linkState  = Provider.of<AppLinkState>(context);

  }
  void returnHome() {
    widget.goHome();
    // AppLinkState linkState = Provider.of<AppLinkState>(context);
    // linkState.setLink(Uri(scheme: "borrowmii1337", host: "home"));
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  // widget.goHome();

  //   });
    // Always go home, replacing the stack
          // context.goNamed("home");
  }
  // _willPopCallback removed (unused)
  @override
  Widget build(BuildContext context) {
    Widget currentScreen;
    String title;
    // GoRouter.of(context).go("/");
    // Navigator.push(context, Route(settings: RouteSettings(name: "home")));
    // print();
    switch(_bigStepper.currentStep) {
      case 0:
        currentScreen = ItemStandardView(item: widget.item, onPressed: _bigStepper.next,);
        title = widget.item.itemName;
        break;
      case 1: 
        currentScreen = Step1BorrowItem(next: () {
          // On submit, go home
          // context.goNamed("/");
          // widget.goHome();
          returnHome();
          // context.goNamed("home");
        });
        title = "${widget.item.itemName} Borrow Duration";
        break;
      default:
        currentScreen = Text("Whoops!");
        title = "Whoops!";
    }

    return 
    PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, _) async {
        returnHome();
      },
      child: 
    Scaffold(
      appBar: AppBar(
        title: Text(title),
        leading: BackButton(onPressed: () {
          if (_bigStepper.currentStep == 0) {
          // widget.goHome();
          returnHome();
          } else {
          // widget.goHome();
          returnHome();

            // _bigStepper.previous();
          }
        }),
      ),
      body: 
         Align(
          alignment: Alignment.topLeft,
          child: currentScreen,
        ),
    )
    );
  }
}