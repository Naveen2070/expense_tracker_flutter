import 'package:expense_tracker/ui/widgets/list/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense_model.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList({super.key, required this.expenses});

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (ctx, index) => ExpenseItem(expenses[index]));
  }
}
