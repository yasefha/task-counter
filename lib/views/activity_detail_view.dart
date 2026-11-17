
import 'package:flutter/material.dart';

import '../viewmodels/activity_viewmodel.dart';

class ActivityDetailView extends StatelessWidget {
  final ActivityViewModel viewModel;
  final int activityId;

  const ActivityDetailView({
    super.key,
    required this.viewModel,
    required this.activityId,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, child) {
        final activity = viewModel.getActivityById(activityId);

        if (activity == null) {
          return const Scaffold(
            body: Center(
              child: Text('Aktivitas tidak ditemukan.'),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Detail Aktivitas'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),

                Text(
                  activity.name,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall,
                ),

                const SizedBox(height: 40),

                const Text(
                  'Jumlah Tugas Selesai',
                  style: TextStyle(fontSize: 16),
                ),

                const SizedBox(height: 12),

                Text(
                  '${activity.counter}',
                  style: const TextStyle(
                    fontSize: 64,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 30),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton.filled(
                      onPressed: () {
                        final oldCounter = activity.counter;

                        viewModel.decrementCounter(activityId);

                        if (oldCounter > 0) {
                          _showCounterSnackbar(
                            context,
                            'Counter dikurangi.',
                          );
                        }
                      },
                      icon: const Icon(Icons.remove),
                    ),

                    const SizedBox(width: 24),

                    IconButton.filled(
                      onPressed: () {
                        viewModel.incrementCounter(activityId);

                        _showCounterSnackbar(
                          context,
                          'Counter ditambahkan.',
                        );
                      },
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      _confirmReset(context);
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reset Counter'),
                  ),
                ),

                const Spacer(),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      _confirmDelete(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    icon: const Icon(Icons.delete_outline),
                    label: const Text('Hapus Aktivitas'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showCounterSnackbar(
    BuildContext context,
    String message,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _confirmReset(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Reset Counter?'),
          content: const Text(
            'Apakah kamu yakin ingin mengembalikan counter menjadi 0?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                viewModel.resetCounter(activityId);
                Navigator.pop(dialogContext);

                _showCounterSnackbar(
                  context,
                  'Counter berhasil direset.',
                );
              },
              child: const Text('Reset'),
            ),
          ],
        );
      },
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Hapus Aktivitas?'),
          content: const Text(
            'Aktivitas ini akan dihapus dari daftar. Apakah kamu yakin?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                viewModel.deleteActivity(activityId);

                Navigator.pop(dialogContext);
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Aktivitas berhasil dihapus.'),
                  ),
                );
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }
}
