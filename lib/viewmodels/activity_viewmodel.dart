
import 'package:flutter/material.dart';

import '../models/activity_model.dart';
import '../repositories/activity_repository.dart';

class ActivityViewModel extends ChangeNotifier {
  final ActivityRepository _repository;

  ActivityViewModel(this._repository);

  List<Activity> get activities {
    return _repository.getAllActivities();
  }

  Activity? getActivityById(int id) {
    return _repository.getActivityById(id);
  }

  void addActivity(String name) {
    _repository.addActivity(name);
    notifyListeners();
  }

  void updateActivity(int id, String name) {
    _repository.updateActivity(id, name);
    notifyListeners();
  }

  void deleteActivity(int id) {
    _repository.deleteActivity(id);
    notifyListeners();
  }

  void incrementCounter(int id) {
    final activity = getActivityById(id);

    if (activity != null) {
      _repository.updateCounter(id, activity.counter + 1);
      notifyListeners();
    }
  }

  void decrementCounter(int id) {
    final activity = getActivityById(id);

    if (activity != null && activity.counter > 0) {
      _repository.updateCounter(id, activity.counter - 1);
      notifyListeners();
    }
  }

  void resetCounter(int id) {
    _repository.updateCounter(id, 0);
    notifyListeners();
  }
}
