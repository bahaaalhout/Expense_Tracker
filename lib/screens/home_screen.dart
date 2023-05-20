import 'package:fifth_app/widgets/chart/chart.dart';

import 'package:fifth_app/widgets/expenses_list/expenses_list.dart';
import 'package:flutter/material.dart';
import '../data/expense.dart';
import '../widgets/bottom_model_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Expense> expenesList = [
    Expense(
      category: CategoryList.leisure,
      amount: 14.99,
      date: DateTime.now(),
      title: 'Cenima',
    ),
    Expense(
      category: CategoryList.work,
      amount: 10.99,
      date: DateTime.now(),
      title: 'Doctor',
    ),
  ];
  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: NewExpense(
            onAddExpense: _addingNewExpense,
          )),
    );
  }

  void _addingNewExpense(Expense expense) {
    setState(() {
      expenesList.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = expenesList.indexOf(expense);
    setState(() {
      expenesList.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Removed'),
      duration: const Duration(seconds: 3),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          setState(() {
            expenesList.insert(expenseIndex, expense);
          });
        },
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text('There\'s no available expenses'),
    );
    if (expenesList.isNotEmpty) {
      mainContent = ExpensesList(
        expense: expenesList,
        removingExpense: _removeExpense,
      );
    }
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Flutter expense Tracker',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: width <= 600
          ? Column(
              children: [
                Chart(expenses: expenesList),
                const SizedBox(
                  height: 10,
                ),
                Expanded(child: mainContent),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(child: Chart(expenses: expenesList)),
                const SizedBox(
                  width: 5,
                ),
                Expanded(child: mainContent),
              ],
            ),
    );
  }
}
