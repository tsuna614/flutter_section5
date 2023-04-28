import 'package:flutter/material.dart';
import '../models/expense.dart';
import 'expenses_list/expenses_list.dart';
import './new_expense.dart';
import './chart/chart.dart';

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
        useSafeArea: true,
        isScrollControlled: true, // make the sheet fullscreen
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    // print(MediaQuery.of(context).size.width);
    // print(MediaQuery.of(context).size.height);
    return Scaffold(
        appBar: AppBar(
            // centerTitle: false,
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
                  if (screenWidth < 600) ...[
                    Chart(expenses: _registeredExpenses),
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                      color: Theme.of(context).dividerColor,
                      height: 2,
                    ),
                    Expanded(
                      child: ExpensesList(
                        expenses: _registeredExpenses,
                        onDismissExpense: _removeExpense,
                      ),
                    ),
                  ] else ...[
                    Row(
                      children: [
                        Expanded(child: Chart(expenses: _registeredExpenses)),
                        Expanded(
                          child: ExpensesList(
                            expenses: _registeredExpenses,
                            onDismissExpense: _removeExpense,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              )
            : Center(
                child: Text(
                  "No expenses found. Start adding new expenses!",
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
              ));
  }
}
