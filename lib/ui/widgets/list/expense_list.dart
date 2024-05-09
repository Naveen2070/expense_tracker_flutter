import 'package:expense_tracker/ui/widgets/list/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense_model.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList(
      {super.key, required this.expenses, required this.onRemoveExpense});

  final List<Expense> expenses;

  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (ctx, index) => Dismissible(
            key: ValueKey(expenses[index]),
            background: Card(
              color: Theme.of(context).colorScheme.error.withOpacity(0.5),
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            ),
            onDismissed: (direction) => onRemoveExpense(expenses[index]),
            child: ExpenseItem(expenses[index])));
  }
}
