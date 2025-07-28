import 'package:flutter/material.dart';
import 'managers/expenses.dart';
import 'screens/add_expenses_screen.dart';

void main() {
  runApp(const TotalityApp());
}

class TotalityApp extends StatelessWidget {
  const TotalityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Totality Budget App',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Expense> _expenses = [];

  void _addExpense(Expense expense) {
    setState(() {
      _expenses.add(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Totality')),
      body: ListView.builder(
        itemCount: _expenses.length,
        itemBuilder: (context, index) {
          final expense = _expenses[index];
          return ListTile(
            title: Text(expense.category),
            subtitle: Text(
                '${expense.amount.toStringAsFixed(2)} - ${expense.date.toLocal()}'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddExpensesScreen(onAddExpense: _addExpense),
            )),
        child: const Icon(Icons.add),
      ),
    );
  }
}
