import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app_riverpod/models/enums.dart';

final dateProvider = StateProvider<String>((ref) => "dd / mm / yyyy");
final timeProvider = StateProvider<String>((ref) => "00 H : 00 M");
final categoryProvider = StateProvider<int>((ref) => Category.general.value);
final priorityProvider =
    StateProvider<List<bool>>((ref) => [false, true, false]);
final selectedPriorityProvider =
    StateProvider<int>((ref) => Priority.medium.value);
