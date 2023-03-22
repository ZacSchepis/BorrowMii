class modelViewController {
  static final modelViewController _instance = modelViewController._internal();

  // using a factory is important
  // because it promises to return _an_ object of this type
  // but it doesn't promise to make a new one.
  factory modelViewController() {
    return _instance;
  }

  // This named constructor is the "real" constructor
  // It'll be called exactly once, by the static property assignment above
  // it's also private, so it can only be called in this class
  modelViewController._internal() {
    // initialization logic
    print("test mvc");
  }

  // rest of class as normal, for example:
  void openFile() {}
  void writeFile() {}
}