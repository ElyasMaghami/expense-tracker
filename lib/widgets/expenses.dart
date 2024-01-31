import 'package:expensetracker/new_expense.dart';
import 'package:expensetracker/widgets/chart/chart.dart';
import 'package:expensetracker/widgets/expenses_list/expenses_list.dart';
import 'package:expensetracker/models/expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registerExpense = [
    Expense(
        title: 'football',
        amount: 19,
        date: DateTime.now(),
        category: Category.leisure),
    Expense(
        title: 'clothe',
        amount: 342,
        date: DateTime.now(),
        category: Category.work),
    Expense(
        title: 'pizza',
        amount: 19,
        date: DateTime.now(),
        category: Category.food),
  ];

  // in function baray onTap
  //addExpense hastesh ke dar appBar mibashad ;
  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: ((ctx) => NewExpense(
            onAddExpense: _addExpense,
          )),
    );
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registerExpense.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registerExpense.indexOf(expense);

    setState(() {
      _registerExpense.remove(expense);
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: const Duration(seconds: 2),
          content: const Text('Expense Delete'),
          action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                setState(() {
                  _registerExpense.insert(expenseIndex, expense);
                });
              }),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    //in ghsmat baray popup khali boodan lis az maincontent stefadeh mikonim ;
    Widget mainContent = const Center(
      child: Text('No Expense Item is here'),
    );
    if (_registerExpense.isNotEmpty) {
      mainContent = ExpensesList(
          expenses: _registerExpense, onRemoveExpense: _removeExpense);
    }
    ;

    return Scaffold(
        appBar: AppBar(
          title: const Text('flutter Expense'),
          actions: [
            IconButton(
              onPressed: _openAddExpenseOverlay,
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        //
        body: width < 600
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Chart(expenses: _registerExpense),
                  Expanded(child: mainContent),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: Chart(expenses: _registerExpense)),
                  Expanded(
                    child: mainContent,
                  ),
                ],
              ));
  }
}
