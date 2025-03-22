import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WaterProvider extends ChangeNotifier {
  int _waterIntake = 0;
  int _goal = 2000; // Default goal in ml

  int _myCup = 200;

  int get waterIntake => _waterIntake;
  int get goal => _goal;
  int get  myCup => _myCup;

  WaterProvider() {
    _loadWaterData();
  }
  Future<void> _loadWaterData() async {
    final prefs = await SharedPreferences.getInstance();
    _waterIntake = prefs.getInt('waterIntake') ?? 0;

    _goal = prefs.getInt('waterGoal') ?? 2000;
    _myCup = prefs.getInt('MyCup') ?? 200;
    notifyListeners();
  }

  Future<void> addWater(int amount) async {
    _waterIntake += amount;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('waterIntake', _waterIntake);
    notifyListeners();
  }

  Future<void> resetWaterIntake() async {
    _waterIntake = 0;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('waterIntake', _waterIntake);
    notifyListeners();
  }
  Future<void> setGoal(int newGoal) async {
    _goal = newGoal;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('waterGoal', newGoal);
    notifyListeners();
  }

  Future<void> setMycup(int value) async{
    _myCup = value;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('MyCup', value);
    notifyListeners();
  }

}
