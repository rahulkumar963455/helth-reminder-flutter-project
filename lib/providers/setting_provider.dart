import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingProvider extends ChangeNotifier {
  String _gender = "null";
  String _weight = "57 kg";
  String _wakeUpTime = "06:00 AM";
  String _bedTime = "10:00 PM";
  String _themeMode = "Default"; // Light or Dark mode

  // Getters
  String get gender => _gender;
  String get weight => _weight;
  String get wakeUpTime => _wakeUpTime;
  String get bedTime => _bedTime;
  String get themeMode => _themeMode;

  SettingProvider() {
    _loadSettings();
  }

  // Load settings from SharedPreferences
  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    _gender = prefs.getString('gender') ?? "Male";
    _weight = prefs.getString('weight') ?? "57 kg";
    _wakeUpTime = prefs.getString('wakeupTime') ?? "06:00 AM";
    _bedTime = prefs.getString('bedtime') ?? "10:20 PM";
    _themeMode = prefs.getString('themeMode') ?? "Default";
    notifyListeners();
  }

  // Update gender
  Future<void> updateGender(String newGender) async {
    _gender = newGender;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('gender', newGender);
    notifyListeners();
  }

  // Update weight
  Future<void> updateWeight(String newWeight) async {
    _weight = newWeight;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('weight', newWeight);
    notifyListeners();
  }

  // Update wake-up time
  Future<void> updateWakeUpTime(String newWakeUpTime) async {
    _wakeUpTime = newWakeUpTime;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('wakeUpTime', newWakeUpTime);
    notifyListeners();
  }

  // Update bedtime
  Future<void> updateBedTime(String newBedTime) async {
    _bedTime = newBedTime;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('bedTime', newBedTime);
    notifyListeners();
  }

  // Update theme mode (Light/Dark)
  Future<void> updateThemeMode(String newThemeMode) async {
    _themeMode = newThemeMode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('themeMode', newThemeMode);
    notifyListeners();
  }
}
