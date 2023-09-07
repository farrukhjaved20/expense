import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingTotal;

  const ChartBar(this.label, this.spendingAmount, this.spendingTotal, {super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (p0, p1) {
      return Column(
        children: <Widget>[
          SizedBox(
            height: p1.maxHeight * 0.15, //text ka ha
            child: FittedBox(
              child: Text('\$${spendingAmount.toStringAsFixed(0)}'),
            ),
          ),
          SizedBox(
            height: p1.maxHeight * 0.05,
          ),
          SizedBox(
            height: p1.maxHeight * 0.6,
            width: 10,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      color: const Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(50)),
                ),
              
                FractionallySizedBox(
                  heightFactor: spendingTotal,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: p1.maxHeight * 0.04,
          ),
          SizedBox(
            height: p1.maxHeight * 0.15,
            child: FittedBox(child: Text(label)),
          ),
        ],
      );
    });
  }
}
