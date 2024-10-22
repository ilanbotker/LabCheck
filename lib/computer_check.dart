class ComputerCheck {
  bool labWashed = false;
  bool binEmptied = false;
  bool whiteboardCleaned = false;
  bool hasBucket = false;
  bool hasWhiteboardEraser = false;
  bool hasMop = false;
  bool hasBroom = false;
  bool hasWiper = false;
  bool hasGarbageCan = false;

  List<Map<String, bool>> computers = List.generate(
    20, // Assuming 20 computers
        (index) => {
      'drive': false,
      'screen': false,
      'mouse': false,
      'keyboard': false,
      'startup': false,
      'internet': false,
    },
  );

  String? checkerName;
  String? labNumber;

  // Method to convert the object to a map for Firebase
  Map<String, dynamic> toJson() {
    return {
      'labWashed': labWashed,
      'binEmptied': binEmptied,
      'whiteboardCleaned': whiteboardCleaned,
      'hasBucket': hasBucket,
      'hasWhiteboardEraser': hasWhiteboardEraser,
      'hasMop': hasMop,
      'hasBroom': hasBroom,
      'hasWiper': hasWiper,
      'hasGarbageCan': hasGarbageCan,
      'computers': computers,
      'checkerName': checkerName,
      'labNumber': labNumber,
    };
  }
}