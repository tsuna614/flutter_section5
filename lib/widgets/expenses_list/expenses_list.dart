import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

import '../../models/expense.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.onDismissExpense});

  final List<Expense> expenses;
  final void Function(Expense expense) onDismissExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      // 2 dong tren co tac dung khi quay ngang dt, neu khong co se bao loi
      // ly do bao loi: ListView se lam nguyen cai list keo dai full man hinh,
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
        key: ValueKey(expenses[index]),
        onDismissed: (direction) {
          onDismissExpense(expenses[index]);
        },
        background: Container(
          color: Colors.red.withOpacity(0.9),
        ),
        child: ExpenseItem(expenses[index]),
      ),
    );
  }
}
