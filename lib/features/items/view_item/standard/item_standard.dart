import 'package:app_links/app_links.dart';
import 'package:borrow_mii/core/constants/item_status.dart';
import 'package:borrow_mii/core/controllers/stepper_controller.dart';
import 'package:borrow_mii/data/datasources/app_linkstate_datasource.dart';
import 'package:borrow_mii/data/models/borrow_order.dart';
import 'package:borrow_mii/data/repositories/item_repository.dart';
import 'package:borrow_mii/features/items/view_item/standard/item_standard_view.dart';
import 'package:borrow_mii/features/items/view_item/standard/step100_return_item.dart';
import 'package:borrow_mii/features/items/view_item/standard/step1_borrow_item.dart';
// import 'package:borrow_mii/main.dart';
import 'package:borrow_mii/widgets/skeletons/item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

enum Steps {
  initial(0),
  borrow(1),
  finish(3),
  borrowReturn(100);

  final int value;
  const Steps(this.value);
}

class ItemStandard extends ItemEntityViewModel {
  final VoidCallback goHome;
  const ItemStandard({super.key, required super.item, required this.goHome});

  @override
  State<ItemStandard> createState() => _ItemStandardWidgetState();
}

class _ItemStandardWidgetState extends State<ItemStandard> {
  late final StepperController _bigStepper;
  late final BorrowOrder _order;
  final ItemRepository _repo = ItemRepository();
  bool _datePicked = false;

  @override
  void initState() {
    super.initState();
    _bigStepper = StepperController(
        maxSteps: 100,
        onBackAtFirstStep: returnHome,
        onStepChanged: () => setState(() {}));
    _order = BorrowOrder(
        name: widget.item.name ?? "",
        itemId: widget.item.id,
        ownerId: widget.item.ownerId,
        terms: widget.item.terms,
        borrowDate: DateTime.now(),
        status: ItemStatus.pendingBorrow,
        returnDate: DateTime.now().add(const Duration(days: 30)));
  }

  void returnHome() {
    widget.goHome();
  }
  Future<void> borrowItem() async {
    try {
      final r = await _repo.addBorrowOrder(context, _order);
      returnHome();
    } catch (e) {
      print("Could not borrow item ${e.toString()}", );
    }
  }

  void _onNext() {
    final borrowerId = widget.item.borrowerId;
    if(widget.item.amIBorrowingThis) {
      _bigStepper.goTo(99);
    } 
    if(borrowerId == null || borrowerId.isEmpty) {
      _bigStepper.next();
    }
    else {
      // _bigStepper.next();
    }
  }
  @override
  Widget build(BuildContext context) {
    Widget currentScreen;
    String title;
    String? name = widget.item.name;
    // String btnText;
    // if(widget.item.amIBorrowingThis) {
      // btnText = "Return item";
    // }
    String btnText = widget.item.amIBorrowingThis ? "Return item" : "Borrow item";
    switch (_bigStepper.currentStep) {
      case 0:
        currentScreen = ItemStandardView(
          item: widget.item,
          onPressed: _onNext,
          buttonText: btnText,
        );
        // if(name != null) {
        title = name ?? "";
        // }
        break;
      case 1:
        currentScreen = Step1BorrowItem(
          next: () {
            returnHome();
          },
          borrow: borrowItem,
          returnDate: _order.returnDate,
          borrowDate: _order.borrowDate,
          setBorrowDate: (v) => setState(() => _order.borrowDate = v),
          setReturnDate: (v) => setState(() => _order.returnDate = v),
          picked: _datePicked,
          setPicked: (v) => setState(() => _datePicked = v),
          item: widget.item
        );

        title = "Borrow Duration" ?? "";
        break;
      case 99:
        currentScreen = Step100ReturnItem(itemId: widget.item.id,);
        title ="";
        break;
      default:
        currentScreen = Text("Whoops!");
        title = "Whoops!";
    }

    return PopScope(
        canPop: true,
        onPopInvokedWithResult: (didPop, _) async {
          returnHome();
        },
        child: Scaffold(
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
          body: Align(
            alignment: Alignment.topLeft,
            child: currentScreen,
          ),
        ));
  }
}
