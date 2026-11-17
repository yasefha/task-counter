
import '../models/activity_model.dart';

class ActivityData {
  final List<Activity> activities = [
    Activity(
      id: 1,
      name: 'Tugas Pemrograman Mobile',
    ),
    Activity(
      id: 2,
      name: 'Tugas Pengolahan Citra',
    ),
    Activity(
      id: 3,
      name: 'Tugas Keamanan Siber',
    ),
  ];

  int _nextId = 4;

  int generateId() {
    return _nextId++;
  }
}
