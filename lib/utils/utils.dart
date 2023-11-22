import 'package:intl/intl.dart';

class Utils {
  static final Map<String, int> days = {
    "Monday": 1,
    "Tuesday": 2,
    "Wednesday": 3,
    "Thursday": 4,
    "Friday": 5,
    "Saturday": 0,
    "Sunday": 0
  };

  static final Map<int, String> times = {
    1: "from 8AM to 8:50AM",
    2: "from 8:50AM to 9:40AM",
    3: "from 9:40AM to 10:30AM",
    4: "from 10:30AM to 11:20AM",
    5: "from 11:20AM to 12:10PM",
    6: "from 12:10PM to 1PM",
    7: "from 1PM to 1:50PM",
    8: "from 1:50PM to 2:40PM",
    9: "from 2:40PM to 3:30PM",
    10: "from 3:30PM to 4:20PM",
    11: "from 4:20PM to 5:10PM",
    12: "from 5:10PM to 6PM",
    13: "from 6PM to 6:50PM",
  };

  static bool _isCurrentDateInRange(DateTime currentDate, DateTime startDate, DateTime endDate) {
    return (currentDate.isAfter(startDate) && currentDate.isBefore(endDate)) || currentDate.isAtSameMomentAs(startDate);
  }

  static int currentClassTime(DateTime currentDate) {
    if (_isCurrentDateInRange(currentDate, DateFormat("kk:mm").parse("08:00"), DateFormat("kk:mm").parse("08:50"))) {
      return 1;
    } else if (_isCurrentDateInRange(
        currentDate, DateFormat("kk:mm").parse("08:50"), DateFormat("kk:mm").parse("09:40"))) {
      return 2;
    } else if (_isCurrentDateInRange(
        currentDate, DateFormat("kk:mm").parse("09:40"), DateFormat("kk:mm").parse("10:30"))) {
      return 3;
    } else if (_isCurrentDateInRange(
        currentDate, DateFormat("kk:mm").parse("10:30"), DateFormat("kk:mm").parse("11:20"))) {
      return 4;
    } else if (_isCurrentDateInRange(
        currentDate, DateFormat("kk:mm").parse("11:20"), DateFormat("kk:mm").parse("12:10"))) {
      return 5;
    } else if (_isCurrentDateInRange(
        currentDate, DateFormat("kk:mm").parse("12:10"), DateFormat("kk:mm").parse("13:00"))) {
      return 6;
    } else if (_isCurrentDateInRange(
        currentDate, DateFormat("kk:mm").parse("13:00"), DateFormat("kk:mm").parse("13:50"))) {
      return 7;
    } else if (_isCurrentDateInRange(
        currentDate, DateFormat("kk:mm").parse("13:50"), DateFormat("kk:mm").parse("14:40"))) {
      return 8;
    } else if (_isCurrentDateInRange(
        currentDate, DateFormat("kk:mm").parse("14:40"), DateFormat("kk:mm").parse("15:30"))) {
      return 9;
    } else if (_isCurrentDateInRange(
        currentDate, DateFormat("kk:mm").parse("15:30"), DateFormat("kk:mm").parse("16:20"))) {
      return 10;
    } else if (_isCurrentDateInRange(
        currentDate, DateFormat("kk:mm").parse("16:20"), DateFormat("kk:mm").parse("17:10"))) {
      return 11;
    } else if (_isCurrentDateInRange(
        currentDate, DateFormat("kk:mm").parse("17:10"), DateFormat("kk:mm").parse("18:00"))) {
      return 12;
    } else if (_isCurrentDateInRange(
        currentDate, DateFormat("kk:mm").parse("18:00"), DateFormat("kk:mm").parse("18:50"))) {
      return 13;
    } else {
      return 0;
    }
  }
}
