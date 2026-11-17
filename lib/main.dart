
import 'package:flutter/material.dart';

import 'data/activity_data.dart';
import 'repositories/activity_repository.dart';
import 'viewmodels/activity_viewmodel.dart';
import 'views/home_view.dart';

void main() {
  final data = ActivityData();
  final repository = ActivityRepository(data);
  final viewModel = ActivityViewModel(repository);

  runApp(TaskCounterApp(viewModel: viewModel));
}

class TaskCounterApp extends StatelessWidget {
  final ActivityViewModel viewModel;

  const TaskCounterApp({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Counter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
        ),
        useMaterial3: true,
      ),
      home: HomeView(viewModel: viewModel),
    );
  }
}
