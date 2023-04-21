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

  void _presentDatePicker() {
    final initialDate = DateTime.now();
    final firstDate = DateTime(2000, 1, 1);
    final lastDate =
        DateTime(initialDate.year + 10, initialDate.month, initialDate.day);
    showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate);
  }

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
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  prefixText:
                      '\$ ', // text nay se tu dong them vao khi nguoi dung click vao TextField, tuy nhien se khong duoc luu lai
                  label: Text('Amount'),
                ),
              ),
            ),
            // TextField khi duoc cho vao children cua Row phai bao trong Extended neu khong se bi loi (yea i don't get it either)
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                // align the contents to the right
                crossAxisAlignment: CrossAxisAlignment.center,
                // center the contents vertically
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  const Text('Selected Date'),
                  IconButton(
                    onPressed: _presentDatePicker,
                    icon: const Icon(Icons.calendar_month),
                  )
                ],
              ),
            )
          ],
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
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  // close context (co nghia la close nguyen Widget build(BuildContext context))
                },
                child: const Text('Cancel')),
          ],
        ),
      ]),
    );
  }
}
