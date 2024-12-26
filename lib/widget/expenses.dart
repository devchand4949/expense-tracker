import 'package:expense_tracker/model/expense.dart';
import 'package:expense_tracker/widget/new_expense.dart';
import 'package:flutter/material.dart';
import 'expenses_list/expenses_list.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: 'flutter course',
        amout: 23,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: 'Burger',
        amout: 49,
        date: DateTime.now(),
        category: Category.food)
  ];
  void _openAddExpenseOverlay() {
    //NewExpense is widget you can watch new_expense screen
    showModalBottomSheet(
      isScrollControlled: true,//open full screen
        context: context,
        builder: (context) => NewExpense(
              onAddExpense: _addExpense,
            ));
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense); //add data in register List
    });
  }

  @override
  Widget build(BuildContext context) {
    // 2) create build method and add scaffold 3->expense screen
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: Column(
        children: [
          Text("The chart"),
          Expanded(
              child: ExpensesList(
                  expenses:
                      _registeredExpenses)) //register expense is a list when add data
        ],
      ),
    );
  }
}
