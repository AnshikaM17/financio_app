import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/home_viewmodel.dart';

class DailyHabitSheet extends StatelessWidget {
  const DailyHabitSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeViewModel>();

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
      child: vm.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Today’s Habit',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                Text(
                  vm.dailyHabitText ?? 'No habit available',
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: vm.habitCompleted
                        ? null
                        : () async {
                            await vm.completeDailyHabit(context);
                            Navigator.pop(context);
                          },
                    child: Text(
                      vm.habitCompleted
                          ? 'Completed Today ✅'
                          : 'Mark as Done (+5 XP)',
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
