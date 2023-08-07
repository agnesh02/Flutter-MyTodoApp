enum Priority {
  high(0),
  medium(1),
  low(2);

  final int value;

  const Priority(this.value);
}

enum Category {
  learn(1),
  work(2),
  general(3);

  final int value;

  const Category(this.value);
}

// extension PriorityExtension on Priority {
//   String get value {
//     switch (this) {
//       case Priority.high:
//         return "High";
//       case Priority.medium:
//         return "Medium";
//       case Priority.low:
//         return "Low";
//     }
//   }
// }
//
// extension CategoryExtension on Category {
//   String get value {
//     switch (this) {
//       case Category.learn:
//         return "LRN";
//       case Category.work:
//         return "WRK";
//       case Category.general:
//         return "GEN";
//       default:
//         throw Exception("Invalid Category value.");
//     }
//   }
// }
