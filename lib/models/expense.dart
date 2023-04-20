import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum Category { food, travel, leisure, work } // enum creates a custom data type

class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category; // Category is the custom data type created above
}
