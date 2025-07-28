import 'package:flutter/material.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  String _selectedPeriod = 'Monthly';
  final TextEditingController _budgetController = TextEditingController();
  bool _canShowSummary = false;

  final Map<String, TextEditingController> _controllers = {
    'Housing': TextEditingController(text: '0'),
    'Bills/Utilities': TextEditingController(text: '0'),
    'Shopping': TextEditingController(text: '0'),
    'Entertainment': TextEditingController(text: '0'),
    'Tax': TextEditingController(text: '0'),
  };

  @override
  void dispose() {
    _budgetController.dispose();
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _setPeriod(String period) {
    setState(() {
      _selectedPeriod = period;
    });
  }

  bool _validateInputs() {
    final budget = double.tryParse(_budgetController.text);
    if (budget == null || budget <= 0) {
      _showError('Please enter a valid budget.');
      return false;
    }

    final hasExpense = _controllers.values.any((c) {
      final value = double.tryParse(c.text);
      return value != null && value > 0;
    });

    if (!hasExpense) {
      _showError('Please enter at least one expense category.');
      return false;
    }

    return true;
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _saveExpenses() {
    if (_validateInputs()) {
      setState(() {
        _canShowSummary = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Expenses saved')),
      );
    }
  }

  void _navigateToSummary() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Expenses')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: ['Daily', 'Monthly', 'Yearly'].map((period) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ChoiceChip(
                    label: Text(period),
                    selected: _selectedPeriod == period,
                    onSelected: (_) => _setPeriod(period),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),

            Text("Add your $_selectedPeriod budget:"),
            const SizedBox(height: 8),
            TextField(
              controller: _budgetController,
              decoration: const InputDecoration(
                labelText: 'Total Budget',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 24),

            Text(
              "Add your $_selectedPeriod expenses for these 5 categories:",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            ..._controllers.entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: TextField(
                  controller: entry.value,
                  decoration: InputDecoration(
                    labelText: entry.key,
                    border: const OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
              );
            }).toList(),

            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _saveExpenses,
                    child: const Text('Save Expenses'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _canShowSummary ? _navigateToSummary : null,
                    child: const Text('Show Summary'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
