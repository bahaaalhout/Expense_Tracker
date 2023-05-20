import 'package:flutter/material.dart';

import '../../data/expense.dart';

class ExpenseCard extends StatelessWidget {
  const ExpenseCard({
    super.key,
    required this.expenseList,
  });
  final Expense expenseList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                expenseList.title,
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${expenseList.amount.toStringAsFixed(2)}',
                  ),
                  Row(
                    children: [
                      Icon(
                        categoryicon[expenseList.category],
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        expenseList.formatedDate,
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
