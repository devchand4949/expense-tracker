import 'package:expense_tracker/model/expense.dart';
import 'package:expense_tracker/widget/chart/chart.dart';
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
      useSafeArea: true,//using safe area
        isScrollControlled: true, //open full screen
        context: context,
        builder: (context) => NewExpense(
              onAddExpense: _addExpense,
            ));
  }

//add data int these method
  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense); //add data in register List
    });
  }

  // remove data widget
  void _removeExpense(Expense expense) {
    // expenseIndex are var.which store the index wise data before remove
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    //fast snakbar show then i remove data then immediately show snakbar
    ScaffoldMessenger.of(context).clearSnackBars();
    //show snakbar message bottom and undo retrive data
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      content: const Text('Text deleted.'),
      action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          }),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget mainContent = const Center(
      child: Text('No expenses found. Start adding some!'),
    );
    //if data is not empty then show
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      ); //register expense is a list when add data
    }

    // 2) create build method and add scaffold 3->expense screen
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _registeredExpenses),
                Expanded(
                    child: mainContent // call mainContent widget (uper che)
                    ),
              ],
            )
          : Row(
              children: [
                Expanded(child: Chart(expenses: _registeredExpenses)),
                Expanded(
                    child: mainContent // call mainContent widget (uper che)
                    ),
              ],
            ),
    );
  }
}
