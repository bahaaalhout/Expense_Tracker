import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat.yMd();
const uuid = Uuid();

enum CategoryList { food, travel, work, leisure }

const categoryicon = {
  CategoryList.food: Icons.dinner_dining,
  CategoryList.travel: Icons.flight_takeoff,
  CategoryList.work: Icons.work,
  CategoryList.leisure: Icons.movie,
};

class Expense {
  String id;
  CategoryList category;
  double amount;
  DateTime date;
  String title;

  Expense(
      {required this.category,
      required this.amount,
      required this.date,
      required this.title})
      : id = uuid.v4();
  String get formatedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  final CategoryList category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount; // sum = sum + expense.amount
    }

    return sum;
  }
}
