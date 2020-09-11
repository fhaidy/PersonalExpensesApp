import 'package:expenses/components/chart_bar.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  Chart(this.recentTransactions);
  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalValue = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        var sameDay = recentTransactions[i].date.day == weekDay.day;
        var sameMonth = recentTransactions[i].date.month == weekDay.month;
        var sameYear = recentTransactions[i].date.year == weekDay.year;
        if (sameDay && sameMonth && sameYear) {
          totalValue += recentTransactions[i].value;
        }
      }

      return {'day': DateFormat.E().format(weekDay)[0], 'value': totalValue};
    }).reversed.toList();
  }

  double get _weekTotalValue {
    return groupedTransactions.fold(
        0.0, (sum, element) => sum + (element['value'] as double));
  }

  @override
  Widget build(BuildContext context) {
    groupedTransactions;
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions
              .map((transaction) => Flexible(
                    fit: FlexFit.tight,
                    child: ChartBar(
                      label: transaction['day'],
                      value: transaction['value'],
                      percentage: _weekTotalValue == 0
                          ? 0
                          : (transaction['value'] as double) / _weekTotalValue,
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
