import 'package:flutter/material.dart';
import 'package:health_reminder/screens/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDataProvider extends ChangeNotifier {
  bool isMale = true;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController bedtimeController = TextEditingController();

  void toggleGender(bool isMaleSelected) {
    isMale = isMaleSelected;
    notifyListeners();
  }

  void updateTimeController(TextEditingController controller, BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      String formattedTime = pickedTime.format(context);
      controller.text = formattedTime;
      notifyListeners();
    }
  }

  Future<void> saveUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', nameController.text);
    await prefs.setString('age', ageController.text);
    await prefs.setString('weight', weightController.text);
    await prefs.setString('wakeupTime', timeController.text);
    await prefs.setString('bedtime', bedtimeController.text);
    await prefs.setBool('isMale', isMale);
  }

  Future<void> loadUserData(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? check = prefs.getString('name'); // Use getString() instead of get()

    if (check != null && check.isNotEmpty) {
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainScreen()),
        );
      }
    }
  }
  bool get isValid {
    return nameController.text.isNotEmpty &&
        ageController.text.isNotEmpty &&
        weightController.text.isNotEmpty &&
        timeController.text.isNotEmpty &&
        bedtimeController.text.isNotEmpty &&
        int.tryParse(ageController.text) != null &&
        double.tryParse(weightController.text) != null;
  }
}
