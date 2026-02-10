import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ChartPie extends StatelessWidget {
  const ChartPie({super.key, required this.expensesByCategory});

  final Map<String, double> expensesByCategory;

  static final Map<String, Color> categoryColors = {
    'Compras': Color(0xFF8E24AA),
    'Alimentação': Color(0xFFF9A825),
    'Transporte': Color(0xFF1E88E5),
    'Lazer': Color(0xFF43A047),
    'Outros': Color(0xFF757575),
  };

  @override
  Widget build(BuildContext context) {
    if (expensesByCategory.isEmpty) {
      return Padding(
        padding: EdgeInsetsGeometry.symmetric(vertical: 16),
        child: Text('Nenhuma despesa nesse mês!'),
      );
    }

    final totalExpenses = expensesByCategory.values.fold(0.0, (a, b) => a + b);

    return Column(
      children: [
        Text(
          'Gastos do Mês',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(height: 8),
        SizedBox(
          height: 200,
          child: PieChart(
            PieChartData(
              sectionsSpace: 1,
              centerSpaceRadius: 15,
              sections: expensesByCategory.entries.map((entry) {
                final percentage = (entry.value / totalExpenses) * 100;
                return PieChartSectionData(
                  value: entry.value,
                  color: categoryColors[entry.key] ?? Colors.grey,
                  title: '${entry.key}\n${percentage.toStringAsFixed(0)}%',
                  radius: 90,
                  titleStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
