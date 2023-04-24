import 'package:flutter/material.dart';
import '../models/expense.dart';
import 'expenses_list/expenses_list.dart';
import './new_expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    // Expense not to be confused with Expenses
    Expense(
        title: 'Flutter Course',
        amount: 19.99,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: 'Cinema',
        amount: 15.69,
        date: DateTime.now(),
        category: Category.leisure),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        isScrollControlled: true, // make the sheet fullscreen
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        context: context,
        builder: (ctx) => NewExpense(onSaveExpense: _addNewExpense));
  }

  void _addNewExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final deletedExpenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    // remove any snackbar that is on screen before creating a new snackbar
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 5),
        content: const Text("Expense deleted."),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(deletedExpenseIndex, expense);
            });
          },
        )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text(
              "Flutter Expense Tracker",
            ),
            actions: [
              IconButton(
                onPressed: _openAddExpenseOverlay,
                icon: const Icon(Icons.add),
              ),
            ]),
        body: _registeredExpenses.isNotEmpty
            ? Column(
                children: [
                  Container(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                      child: const Text(
                        "The chart",
                        style: TextStyle(fontSize: 20),
                      )),
                  Expanded(
                      child: ExpensesList(
                    expenses: _registeredExpenses,
                    onDismissExpense: _removeExpense,
                  )),
                ],
              )
            : const Center(
                child: Text("No expenses found. Start adding new expenses!"),
              ));
  }
}
