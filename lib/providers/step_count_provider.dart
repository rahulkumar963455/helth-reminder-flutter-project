import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class StepCounterProvider with ChangeNotifier {
  int _goals = 0;
  int _steps = 0;
  int _initialSteps = 0;
  double _distance = 0.0;
  double _calories = 0.0;
  double _stepLength = 0.75;
  String _wakeUpTime = "8:40 PM";
  String _bedTime = "10:00 PM";
  StreamSubscription<StepCount>? _stepCountSubscription;

  int get steps => _steps;
  double get distance => _distance;
  double get calories => _calories;
  String get wakeUpTime => _wakeUpTime;
  String get bedTime => _bedTime;
  int get goals => _goals;

  StepCounterProvider() {
    _requestPermissions();
  }

  Future<void> _requestPermissions() async {
    if (await Permission.activityRecognition.request().isGranted) {
      await _loadData();
      _checkResetCondition();
      _startListening();
    }
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    _initialSteps = prefs.getInt('initialSteps') ?? 0;
    _steps = prefs.getInt('steps') ?? 0;
    _goals = prefs.getInt('step_goal') ?? 0; // Load goals
    _wakeUpTime = prefs.getString('wakeUpTime') ?? "06:00 AM";
    _bedTime = prefs.getString('bedTime') ?? "10:00 PM";
    _updateMetrics();
    notifyListeners();
  }

  void _startListening() {
    _stepCountSubscription = Pedometer.stepCountStream.listen(_onStepCount);
  }

  void _onStepCount(StepCount event) {
    _checkResetCondition();
    if (_initialSteps == 0) _initialSteps = event.steps;
    _steps = event.steps - _initialSteps;
    _updateMetrics();
    _saveData();
    notifyListeners();
  }

  void _updateMetrics() {
    _distance = _steps * _stepLength;
    _calories = _steps * 0.04;
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('steps', _steps);
    await prefs.setInt('initialSteps', _initialSteps);
    await prefs.setString('wakeUpTime', _wakeUpTime);
    await prefs.setString('bedTime', _bedTime);
    await prefs.setString('lastResetDate', DateFormat('yyyy-MM-dd').format(DateTime.now()));
  }

  Future<void> _resetSteps() async {
    _steps = 0;
    _distance = 0.0;
    _calories = 0.0;
    _initialSteps = 0;
    await _saveData();
    notifyListeners();
  }

  void _checkResetCondition() async {
    final prefs = await SharedPreferences.getInstance();
    String? lastResetDate = prefs.getString('lastResetDate');
    String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    if (lastResetDate == null || lastResetDate != todayDate) {
      await _resetSteps();
    }
  }

  Future<void> getdata() async {
    final prefs = await SharedPreferences.getInstance();
    _wakeUpTime = prefs.getString('wakeUpTime') ?? "06:00 AM";
    _bedTime = prefs.getString('bedTime') ?? "10:00 PM";
    _goals = prefs.getInt('step_goal') ?? 0; // Ensure goals are loaded
    notifyListeners();
  }

  void updateGoal(int newGoal) async {
    _goals = newGoal;
    await saveGoals(newGoal);
    notifyListeners();
  }

  Future<void> saveGoals(int goals) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('step_goal', goals);
  }

  @override
  void dispose() {
    _stepCountSubscription?.cancel();
    super.dispose();
  }
}
