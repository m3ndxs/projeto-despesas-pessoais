import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/components/chart_pie.dart';
import '/components/chart_bar.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.recentTransaction});

  final List<Transaction> recentTransaction;

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      double totalSum = 0.0;

      for (var i = 0; i < recentTransaction.length; i++) {
        bool sameDay = recentTransaction[i].date.day == weekDay.day;
        bool sameMonth = recentTransaction[i].date.month == weekDay.month;
        bool sameYear = recentTransaction[i].date.year == weekDay.year;

        if (sameDay && sameMonth && sameYear) {
          totalSum += recentTransaction[i].value;
        }
      }

      return {'day': DateFormat.E('pt_BR').format(weekDay)[0], 'value': totalSum};
    }).reversed.toList();
  }

  Map<String, double> get monthlyExpensesByCategory {
    final date = DateTime.now();
    final Map<String, double> map = {};

    for(var transaction in recentTransaction){
      final sameMonth = transaction.date.month == date.month;
      final sameYear = transaction.date.year == date.year;

      if(sameMonth && sameYear){
        map.update(
          transaction.category,
          (value) => value + transaction.value,
          ifAbsent: () => transaction.value,
        );
      }
    }

    return map;
  }

  double get _weekTotalValue {
    return groupedTransactions.fold(0.0, (sum, item) {
      return sum + (item['value'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    groupedTransactions;
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            ChartPie(expensesByCategory: monthlyExpensesByCategory),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: groupedTransactions.map((transaction) {
                return Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                    label: transaction['day'].toString().toUpperCase(), 
                    value: double.parse(transaction['value'].toString()), 
                    percentage: _weekTotalValue == 0 ? 0 : (transaction['value'] as double) / _weekTotalValue,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
