import 'package:flutter/material.dart';
import 'package:expense_tracker/widget/expenses.dart';

void main(){
  runApp(MaterialApp(
    theme: ThemeData(useMaterial3: true),
    home:Expenses(),// 1) call to Expenses() Widget 2-> Expenses screen
  ));
}