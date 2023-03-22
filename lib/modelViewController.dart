class modelViewController {
  static final modelViewController _instance = modelViewController._internal();
  //create instance
  factory modelViewController() {
    return _instance;
  }

 //constructor
  modelViewController._internal() {
    // initialization logic
    print("test mvc");
  }

  // rest of class as normal, for example:
  void openFile() {}
  void writeFile() {}
}