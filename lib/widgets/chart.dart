
import 'package:flutter/material.dart';
import 'package:notifcation/widgets/chartbar.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentransction;
  const Chart(this.recentransction, {super.key});

  List<Map<String, Object>> get GroupedTransactionValues {
    return List.generate(7, (index) {
      //7 jo haw wo dat
      final weekday = DateTime.now().subtract(
        Duration(days: index),
      );

      var totalsum = 0.0;

      for (var i = 0; i < recentransction.length; i++) {
        if (recentransction[i].date.day == weekday.day &&
            recentransction[i].date.month == weekday.month &&
            recentransction[i].date.year == weekday.year) {
          totalsum += recentransction[i].amount;
        }
      }
      print(DateFormat.E().format(weekday));
      print(totalsum);
      return {
        'day': DateFormat.E().format(weekday).substring(0, 1),
        'amount': totalsum,
      };
    });
  }

  double get Totalspending {
    return GroupedTransactionValues.fold(0.0, (previousValue, element) {
      return previousValue + (element['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(GroupedTransactionValues);
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(30),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: GroupedTransactionValues.map((data) {
            return Flexible(
              flex: 5,
              fit: FlexFit.tight,
              child: ChartBar(
                (data['day'] as String),
                (data['amount'] as double),
                Totalspending == 0.0
                    ? 0.0
                    : (data['amount'] as double) / Totalspending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
