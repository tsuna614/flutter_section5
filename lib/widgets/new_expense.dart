import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  // dung de quan ly text user input

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  } // void dispose la mot phan cua flutter widget lifecycle

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(children: [
        TextField(
          controller: _titleController,
          maxLength: 50,
          decoration: const InputDecoration(
            label: Text('Title'),
          ),
        ),
        TextField(
          controller: _amountController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            prefixText:
                '\$ ', // text nay se tu dong them vao khi nguoi dung click vao TextField, tuy nhien se khong duoc luu lai
            label: Text('Amount'),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            ElevatedButton(
              onPressed: () {
                print(_titleController.text);
                print(_amountController.text);
              },
              child: const Text('Save Expense'),
            ),
            const Spacer(),
            TextButton(onPressed: () {}, child: const Text('Cancel')),
          ],
        ),
      ]),
    );
  }
}
