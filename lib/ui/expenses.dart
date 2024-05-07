import 'package:expense_tracker/ui/widgets/new_expense/new_expenses.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/ui/widgets/list/expense_list.dart';
import 'package:expense_tracker/models/expense_model.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: "Flutter course",
        amount: 595,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: "Godzilla",
        amount: 200,
        date: DateTime.now(),
        category: Category.entertainment),
    Expense(
        title: "Guindy to CMBT",
        amount: 595,
        date: DateTime.now(),
        category: Category.travel),
  ];

  void _openAddExpense() {
    showModalBottomSheet(
        context: context, builder: (ctx) => const NewExpenses());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Tracker"),
        actions: [
          IconButton(onPressed: _openAddExpense, icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          const Text("Chart"),
          Expanded(child: ExpenseList(expenses: _registeredExpenses))
        ],
      ),
    );
  }
}
