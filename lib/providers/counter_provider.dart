import 'package:flutter_riverpod/flutter_riverpod.dart';

class CounterProvider extends StateNotifier<int> {
  CounterProvider(super.state);

  void increment() {
    state++;
  }

  void decrement() {
    state--;
  }
}
