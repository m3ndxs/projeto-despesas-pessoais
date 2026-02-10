import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ChartPie extends StatelessWidget {
  const ChartPie({super.key, required this.expensesByCategory});

  final Map<String, double> expensesByCategory;

  @override
  Widget build(BuildContext context) {
    if(expensesByCategory.isEmpty){
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