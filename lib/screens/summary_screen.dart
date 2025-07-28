import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class SummaryScreen extends StatelessWidget {
  final String period;
  final double budget;
  final Map<String, double> expenses;

  const SummaryScreen({
    super.key,
    required this.period,
    required this.budget,
    required this.expenses,
  });

  @override
  Widget build(BuildContext context) {
    final totalExpenses = expenses.values.reduce((a, b) => a + b);
    final remaining = budget - totalExpenses;

    final pieSections = [
      ...expenses.entries.map((entry) => PieChartSectionData(
            value: entry.value,
            title: entry.key,
          )),
      PieChartSectionData(
        value: remaining < 0 ? 0 : remaining,
        title: 'Remaining',
        color: Colors.greenAccent,
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Budget Summary')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              '$period Budget: £${budget.toStringAsFixed(2)}\nTotal Spent: £${totalExpenses.toStringAsFixed(2)}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: PieChart(
                PieChartData(
                  sections: pieSections,
                  sectionsSpace: 4,
                  centerSpaceRadius: 40,
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Suggestions'),
                    content: _buildSuggestions(),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Close'),
                      )
                    ],
                  ),
                );
              },
              child: const Text('View Suggestions'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestions() {
    List<Widget> suggestions = [];
    final totalExpenses = expenses.values.reduce((a, b) => a + b);
    if (totalExpenses > budget) {
      expenses.forEach((category, amount) {
        if (amount > 0) {
          suggestions.add(Text('Consider reducing $category spending by 10%'));
        }
      });
    } else {
      suggestions.add(const Text('Your spending is within budget. Good job!'));
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: suggestions,
    );
  }
}
