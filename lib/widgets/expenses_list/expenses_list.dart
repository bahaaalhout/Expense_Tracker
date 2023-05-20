import '../../data/expense.dart';
import 'package:flutter/material.dart';

import 'expense_card.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expense, required this.removingExpense});
  final List<Expense> expense;
  final void Function(Expense expense) removingExpense;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return ListView.builder(
      itemCount: expense.length,
      itemBuilder: (context, index) => Dismissible(
        direction: width <= 600
            ? DismissDirection.horizontal
            : DismissDirection.startToEnd,
        key: ValueKey(expense[index]),
        background: Container(
          margin: Theme.of(context).cardTheme.margin,
          color: Theme.of(context).colorScheme.error.withOpacity(.75),
          child: Icon(
            Icons.delete,
            color: Theme.of(context).colorScheme.onError,
          ),
        ),
        onDismissed: (direction) {
          removingExpense(expense[index]);
        },
        child: ExpenseCard(
          expenseList: expense[index],
        ),
      ),
    );
  }
}
