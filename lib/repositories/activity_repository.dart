
import '../data/activity_data.dart';
import '../models/activity_model.dart';

class ActivityRepository {
  final ActivityData _data;

  ActivityRepository(this._data);

  List<Activity> getAllActivities() {
    return _data.activities;
  }

  Activity? getActivityById(int id) {
    try {
      return _data.activities.firstWhere(
        (activity) => activity.id == id,
      );
    } catch (_) {
      return null;
    }
  }

  void addActivity(String name) {
    _data.activities.add(
      Activity(
        id: _data.generateId(),
        name: name,
      ),
    );
  }

  void updateActivity(int id, String name) {
    final activity = getActivityById(id);

    if (activity != null) {
      activity.name = name;
    }
  }

  void deleteActivity(int id) {
    _data.activities.removeWhere(
      (activity) => activity.id == id,
    );
  }

  void updateCounter(int id, int counter) {
    final activity = getActivityById(id);

    if (activity != null && counter >= 0) {
      activity.counter = counter;
    }
  }
}
