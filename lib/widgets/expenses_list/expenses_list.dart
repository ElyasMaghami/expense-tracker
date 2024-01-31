import 'package:expensetracker/models/expense.dart';
import 'package:expensetracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

// import 'package:expensetracker/expenses.dart';
class ExpensesList extends StatelessWidget {
  const ExpensesList({
    required this.onRemoveExpense,
    super.key,
    required this.expenses,
  });
  final void Function(Expense expense) onRemoveExpense;

// final void Function
  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: ListView.builder(
          itemCount: expenses.length,
          itemBuilder: (ctx, index) => Dismissible(
            background: Container(
              color: Theme.of(context).colorScheme.error,
              //dar decoration khastam doresh ra gerd konm ama box shod va etefagh jalebi oftad ama nashod .
              // decoration: BoxDecoration(
              //     color: Theme.of(context).colorScheme.error,
              //     borderRadius: BorderRadius.circular(40)),
              margin: EdgeInsets.symmetric(
                  horizontal: Theme.of(context).cardTheme.margin!.horizontal),
            ),
            key: ValueKey(expenses[index]),
            child: ExpenseItem(expenses[index]),
            onDismissed: (duration) {
              onRemoveExpense(expenses[index]);
            },
            // background: ,
          ),
        ),
      ),
    );
  }
}
