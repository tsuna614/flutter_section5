import 'package:flutter/material.dart';

import '../../models/expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    // final Dateformat

    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
              alignment: Alignment.center,
              child: Text(
                expense.title,
                style: Theme.of(context).textTheme.titleLarge,
                // using custom textTheme in main.dart
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Text(
                    '\$${expense.amount.toStringAsFixed(2)}'), // 12.625397 -> 12.62
                const Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[expense.category]),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(expense.formattedDate.toString()),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
