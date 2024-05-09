import 'package:expense_tracker/ui/widgets/chart/chart.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/ui/widgets/new_expense/new_expenses.dart';
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

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final index = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text("Expense deleted"),
      duration: const Duration(seconds: 3),
      action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(index, expense);
            });
          }),
    ));
  }

  void _openAddExpense() {
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpenses(
              onAddExpense: _addExpense,
            ));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget maincontent = const Center(
      child: Text("No expense found. Start adding some!"),
    );

    if (_registeredExpenses.isNotEmpty) {
      maincontent = ExpenseList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Tracker"),
        actions: [
          IconButton(onPressed: _openAddExpense, icon: const Icon(Icons.add))
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _registeredExpenses),
                Expanded(child: maincontent)
              ],
            )
          : Row(
              children: [
                Expanded(child: Chart(expenses: _registeredExpenses)),
                Expanded(child: maincontent)
              ],
            ),
    );
  }
}
