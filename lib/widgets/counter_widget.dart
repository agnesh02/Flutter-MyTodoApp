import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app_riverpod/providers/counter_provider.dart';

class CounterWidget extends ConsumerWidget {
  CounterWidget({super.key});

  final counterProvider =
      StateNotifierProvider<CounterProvider, int>((ref) => CounterProvider(1));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);

    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FloatingActionButton(
            onPressed: () {
              ref.read(counterProvider.notifier).increment();
            },
            child: const Icon(Icons.add),
          ),
          Text(
            counter.toString(),
            style: const TextStyle(fontSize: 40),
          ),
          FloatingActionButton(
            onPressed: () {
              ref.read(counterProvider.notifier).decrement();
            },
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}
