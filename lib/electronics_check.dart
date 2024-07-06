  class ElectronicsCheck {
    // Cleanliness checks (same as ComputerCheck)
    bool labWashed = false;
    bool binEmptied = false;
    bool whiteboardCleaned = false;
    bool hasBucket = false;
    bool hasWhiteboardEraser = false;
    bool hasMop = false;
    bool hasBroom = false;
    bool hasWiper = false;
    bool hasGarbageCan = false;

    // Computing checks (same as ComputerCheck)
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

    // Electronics Equipment checks
    List<Map<String, bool>> equipmentStations = List.generate(
      20, // Assuming 20 equipment stations
          (index) => {
        'oscilloscope': false,
        'signalGenerator': false,
        'dualPowerSupply': false,
        'multimeter': false,
      },
    );

    String? checkerName;

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
        'equipmentStations': equipmentStations,
        'checkerName': checkerName,
      };
    }
  }