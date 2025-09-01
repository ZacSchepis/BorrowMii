
import 'package:team_d_project/core/validators/validator.dart';

class ItemInputValidator extends Validator {
  // Validator v = Validator();
  const ItemInputValidator();
   String? name(String? val) {
    return Validator.stringProp(val, "Name required");
  }
   String? itemName(String? val) {
    return Validator.stringProp(val, "Item name required");

  }
   String? itemDesc(String? val) {
    return Validator.stringProp(val, "Item description required");

  }
   String? itemImg(String? val) {
    return Validator.stringProp(val, "Item image required");
  }  

   String? itemLink(String? val) {
    return Validator.linkProp(val, "URL must be valid");
  }

   String? itemCondition(String? val) {
    return Validator.stringProp(val, "Item condition required");
  }
  String? numericValue(String? val) {
    
  }
  // static String? 

}