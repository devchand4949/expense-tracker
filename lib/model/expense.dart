import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
//3->,<-6

final formatter = DateFormat.yMd();
const uuid = Uuid(); // 4)i->add package Uuid() in const var for get unique id

enum Category { food, travel, leisure, work }//5)ii-> enum is special kind of class represent fix number constant

const categoryIcon = {
  Category.food : Icons.lunch_dining_outlined,
  Category.travel : Icons.flight_takeoff,
  Category.leisure : Icons.movie,
  Category.work : Icons.work
};

class Expense {
  // 3)crate Expense class and intialize final and pass Expense constructors
  Expense({required this.title, required this.amout, required this.date,required this.category})
      : id = uuid
            .v4(); // 4)ii->define uuid ,v4() are generate every unique id ex 1,2,3

  final String id;
  final String title;
  final double amout;
  final DateTime date;
  final Category category; //5)i-> define Caregory class

  String get formattedDate {
    return formatter.format(date);
  }

}
