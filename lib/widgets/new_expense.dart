import 'package:flutter/material.dart';
import '../models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  Category? _selectedCategory = Category.leisure;

  // dung de quan ly text user input
  DateTime?
      _selectedDate; // add a question mark ? to make the variable nullable
  // alternative: late DateTime _selectedDate;

  void _presentDatePicker() async {
    final initialDate = DateTime.now();
    final firstDate = DateTime(2000, 1, 1);
    final lastDate =
        DateTime(initialDate.year + 100, initialDate.month, initialDate.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate);
    setState(() {
      _selectedDate = pickedDate;
    });
    print(pickedDate);
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                    Text((_selectedDate == null)
                        ? "No date selected"
                        : formatter.format(_selectedDate!)),
                    // exclamation mark force dart to assume the variable to not be NULL
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
              const SizedBox(
                width: 10,
              ),
              DropdownButton(
                  value:
                      _selectedCategory, // this will show a temporary category on the dropdown, instead of blank
                  items: Category.values.map((data) {
                    return DropdownMenuItem(
                      value:
                          data, // pass the data into the value, which will be called in the onChanged function
                      child: Text(data.name.toUpperCase()),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (_selectedCategory == null) {
                      return; // if it's null return nothing
                    }
                    setState(() {
                      _selectedCategory = value;
                    });
                  }),
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
        ],
      ),
    );
  }
}
