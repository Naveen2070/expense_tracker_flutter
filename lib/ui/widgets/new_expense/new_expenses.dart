import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense_model.dart';

class NewExpenses extends StatefulWidget {
  const NewExpenses({super.key, required this.onAddExpense});

  final Function(Expense expense) onAddExpense;

  @override
  State<NewExpenses> createState() => _NewExpensesState();
}

class _NewExpensesState extends State<NewExpenses> {
  final _titleHandler = TextEditingController();
  final _amountHandler = TextEditingController();

  DateTime? _selectedDate;
  Category _selectedCatgory = Category.leisure;

  void _openDatePicker() async {
    final now = DateTime.now();
    final first = DateTime(now.year - 1, now.month, now.day);
    final date = await showDatePicker(
        context: context, initialDate: now, firstDate: first, lastDate: now);
    setState(() {
      _selectedDate = date;
    });
  }

  void _handleSubmit() {
    final ammount = double.tryParse(_amountHandler.text);
    final ammountIsInvalid = ammount == null || ammount <= 0;
    if (_titleHandler.text.trim().isEmpty ||
        ammountIsInvalid ||
        _selectedDate == null) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('Invalid input'),
                content: const Text('Please enter vaild data'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Okay"))
                ],
              ));
      return;
    }
    widget.onAddExpense(Expense(
        title: _titleHandler.text,
        amount: ammount,
        date: _selectedDate!,
        category: _selectedCatgory));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleHandler.dispose();
    _amountHandler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keySpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (context, constraints) {
      final maxWidth = constraints.maxWidth;
      constraints.maxWidth;
      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 48, 16, keySpace + 16),
            child: Column(
              children: [
                if (maxWidth >= 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          maxLength: 50,
                          decoration:
                              const InputDecoration(label: Text("Title")),
                          controller: _titleHandler,
                        ),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              prefixText: '₹ ', label: Text("Amount")),
                          controller: _amountHandler,
                        ),
                      ),
                    ],
                  )
                else
                  TextField(
                    maxLength: 50,
                    decoration: const InputDecoration(label: Text("Title")),
                    controller: _titleHandler,
                  ),
                if (maxWidth >= 600)
                  Row(
                    children: [
                      DropdownButton(
                        items: Category.values
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(
                                    e.name.toUpperCase(),
                                  ),
                                ))
                            .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            _selectedCatgory = value;
                          });
                        },
                        value: _selectedCatgory,
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      Expanded(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(_selectedDate == null
                              ? "No date Selected"
                              : formatter.format(_selectedDate!)),
                          IconButton(
                              onPressed: _openDatePicker,
                              icon: const Icon(Icons.calendar_month))
                        ],
                      ))
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              prefixText: '₹ ', label: Text("Amount")),
                          controller: _amountHandler,
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(_selectedDate == null
                              ? "No date Selected"
                              : formatter.format(_selectedDate!)),
                          IconButton(
                              onPressed: _openDatePicker,
                              icon: const Icon(Icons.calendar_month))
                        ],
                      ))
                    ],
                  ),
                const SizedBox(
                  height: 16,
                ),
                if (maxWidth >= 50)
                  Row(
                    children: [
                      const Spacer(),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel")),
                      ElevatedButton(
                          onPressed: _handleSubmit, child: const Text("Save"))
                    ],
                  )
                else
                  Row(
                    children: [
                      DropdownButton(
                        items: Category.values
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(
                                    e.name.toUpperCase(),
                                  ),
                                ))
                            .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            _selectedCatgory = value;
                          });
                        },
                        value: _selectedCatgory,
                      ),
                      const Spacer(),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel")),
                      ElevatedButton(
                          onPressed: _handleSubmit, child: const Text("Save"))
                    ],
                  )
              ],
            ),
          ),
        ),
      );
    });
  }
}
