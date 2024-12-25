import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:expense_tracker/model/expense.dart';

class NewExpense extends StatefulWidget {
  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
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

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
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


          // close button
          Row(
            children: [
              TextButton(
                // close bottom screen
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Close'),
              ),
              ElevatedButton(
                  onPressed: () {
                    print(_titleController.text);
                    print(_amountController.text);
                  },
                  child: Text('get value'))
            ],
          )
        ],
      ),
    );
  }
}
