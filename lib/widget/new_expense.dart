import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:expense_tracker/model/expense.dart';

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
  Category _selectedCategory = Category.work;

// for date
  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      _selectedDate = pickDate;
    });
  }
//ios and android dialogbox show
  void _showDialog() {
    //use for ios dialogbox
    if (Platform.isIOS) {
      showCupertinoDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: Text("Invalid Input"),
            content: Text(
                "please make sure a valid title,amount,date and category was entered."),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Okey'))
            ],
          ));
    }
    else{
      //android dialogbox
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Invalid Input"),
            content: Text(
                "please make sure a valid title,amount,date and category was entered."),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Okey'))
            ],
          ));
    }
  }

  //submit data using validation
  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount < 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {

        _showDialog();// call _showDialog and show mess (line 39)
      return;
    }
    widget.onAddExpense(Expense(
        title: _titleController.text,
        amout: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keybordSpace = MediaQuery.of(context)
        .viewInsets
        .bottom; // responsive, when i rotate phone then insert data  are scrollable
    return SizedBox(
      height: double.infinity,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 48, 16, keybordSpace + 16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              //Title input
              TextField(
                controller: _titleController, // calling to these method
                maxLength: 50,
                decoration: InputDecoration(label: Text('Title')),
              ),
              //amount and date row
              Row(
                children: [
                  Expanded(
                    //amount input
                    child: TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          prefix: Text('\$'), label: Text('Amount')),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  //date input
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          _selectedDate == null
                              ? 'Date not select'
                              : formatter.format(_selectedDate!),
                        ),
                        IconButton(
                            onPressed: _presentDatePicker,
                            icon: Icon(Icons.calendar_month))
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              // close button row
              Row(
                children: [
                  DropdownButton(
                      value: _selectedCategory,
                      items: Category.values
                          .map((category) => DropdownMenuItem(
                              value: category,
                              child: Text(
                                category.name.toUpperCase(),
                              )))
                          .toList(),
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }
                        setState(() {
                          _selectedCategory = value;
                        });
                      }),
                  Spacer(),
                  TextButton(
                    // close bottom screen
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Close'),
                  ),
                  ElevatedButton(
                      onPressed: _submitExpenseData,
                      child: Text('Save Expense'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
