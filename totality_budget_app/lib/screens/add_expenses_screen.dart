import 'package:flutter/material.dart';
import '../managers/expenses.dart';

class AddExpensesScreen extends StatefulWidget {
  final Function(Expense) onAddExpense;
  const AddExpensesScreen({required this.onAddExpense, super.key});

  @override
  State<AddExpensesScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpensesScreen> {
  final _formKey = GlobalKey<FormState>();
  String _category = '';
  double _amount = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Expense')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Category'),
                onSaved: (value) => _category = value ?? '',
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                onSaved: (value) =>
                    _amount = double.tryParse(value ?? '0') ?? 0.0,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _formKey.currentState?.save();
                  final newExpense = Expense(
                    category: _category,
                    amount: _amount,
                    date: DateTime.now(),
                  );
                  widget.onAddExpense(newExpense);
                  Navigator.pop(context);
                },
                child: const Text('Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
