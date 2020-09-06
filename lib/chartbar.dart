import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPctofTOtal;
  ChartBar(this.label, this.spendingAmount, this.spendingPctofTOtal);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 20,
          child:
              FittedBox(child: Text('Rs '+'${spendingAmount.toStringAsFixed(0)}')),
        ), //we pAass only 0 to get rounded off the value
        SizedBox(
          height: 6,
        ),
        Container(
          height: 60,
          width: 15,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 2),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(20)),
              ),
              FractionallySizedBox(
                heightFactor: spendingPctofTOtal,
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20)),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 6,
        ),
        Text(label),
      ],
    );
  }
}
