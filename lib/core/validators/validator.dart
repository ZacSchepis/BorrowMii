
abstract class Validator {
  const Validator();

  static String? stringProp(String? val, String message) {
    if(val == null || val.trim().isEmpty) {
      return message;
    }
    return null;
  }
  static String? linkProp(String? val, String message) {
    String? initial = stringProp(val, message);
    if(initial != null) { 
      return initial;
    }
    bool validUrl = Uri.tryParse(val!)?.hasAbsolutePath ?? false;
    if(!validUrl) {
      return message;
    }
    return null;
  }
  // String? numericProp(String? val, String message) {

  // }
}