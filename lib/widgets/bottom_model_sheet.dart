import 'dart:io';

import 'package:fifth_app/data/expense.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});
  final void Function(Expense expense) onAddExpense;
  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  CategoryList _selectedCategory = CategoryList.leisure;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _datePicker() async {
    var now = DateTime.now();
    var firstDate = DateTime(now.year, now.month, now.day);

    var selectedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: DateTime(2030),
    );
    setState(() {
      _selectedDate = selectedDate;
    });
  }

  void _showingErrorMessage() {
    final enteredAmount = double.tryParse(_amountController.text);
    final checkingAmountControll = enteredAmount == null || enteredAmount <= 0;
    final checkingTitleControll = _titleController.text.trim().isEmpty;
    if (checkingTitleControll ||
        checkingAmountControll ||
        _selectedDate == null) {
      if (Platform.isIOS) {
        showCupertinoDialog(
          context: context,
          builder: ((ctx) => CupertinoAlertDialog(
                title: const Text('Invalid Message'),
                content: Text(
                  checkingTitleControll
                      ? 'Please Enter The Title.'
                      : checkingAmountControll
                          ? 'Please Enter A Number Which Be Greater Than 0.'
                          : 'Please Select Any Date',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    child: const Text('Okay'),
                  ),
                ],
              )),
        );
      } else {
        showDialog(
          context: context,
          builder: ((ctx) => AlertDialog(
                title: const Text('Invalid Message'),
                content: Text(
                  checkingTitleControll
                      ? 'Please Enter The Title.'
                      : checkingAmountControll
                          ? 'Please Enter A Number Which Be Greater Than 0.'
                          : 'Please Select Any Date',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    child: const Text('Okay'),
                  ),
                ],
              )),
        );
      }

      return;
    }
    widget.onAddExpense(
      Expense(
        category: _selectedCategory,
        amount: enteredAmount,
        date: _selectedDate!,
        title: _titleController.text,
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;
      return Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              width <= 600
                  ? titleTextFiled()
                  : Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: titleTextFiled()),
                            const SizedBox(
                              width: 30,
                            ),
                            amountTextFiled(),
                          ],
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
              width <= 600
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        amountTextFiled(),
                        const SizedBox(
                          width: 80,
                        ),
                        dateTextButton(),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            dateTextButton(),
                            const SizedBox(
                              width: 80,
                            ),
                            dropdownButton(),
                          ],
                        ),
                        Row(
                          children: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('Cancel'),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            ElevatedButton(
                              onPressed: _showingErrorMessage,
                              child: const Text('Save Expense'),
                            ),
                          ],
                        ),
                      ],
                    ),
              const SizedBox(
                height: 28,
              ),
              width <= 600
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        dropdownButton(),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: _showingErrorMessage,
                          child: const Text('Save Expense'),
                        ),
                      ],
                    )
                  : const SizedBox(
                      height: 20,
                    ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      );
    });
  }

  DropdownButton<CategoryList> dropdownButton() {
    return DropdownButton(
      value: _selectedCategory,
      items: CategoryList.values
          .map(
            (category) => DropdownMenuItem(
              value: category,
              child: Text(
                category.name.toUpperCase(),
              ),
            ),
          )
          .toList(),
      onChanged: (value) {
        if (value == null) {
          return;
        }
        setState(() {
          _selectedCategory = value;
        });
      },
    );
  }

  TextButton dateTextButton() {
    return TextButton.icon(
      onPressed: _datePicker,
      icon: const Icon(Icons.calendar_month_outlined),
      label: Text(
        _selectedDate == null
            ? 'No Selected Date'
            : formatter.format(_selectedDate!),
      ),
    );
  }

  Expanded amountTextFiled() {
    return Expanded(
      child: TextField(
        controller: _amountController,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          prefixText: '\$ ',
          label: Text('Amount'),
        ),
      ),
    );
  }

  Widget titleTextFiled() {
    return TextField(
      controller: _titleController,
      maxLength: 50,
      decoration: const InputDecoration(
        label: Text('Title'),
      ),
    );
  }
}
