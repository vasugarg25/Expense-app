import 'package:flutter/material.dart';
import './transaction.dart';
import 'package:intl/intl.dart';
import './chartbar.dart';

class Chart extends StatelessWidget {
  final List<transaction> recenTransactions;
  Chart(this.recenTransactions);

  List<Map<String, Object>> get groupedTransactionvalues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;
      for (int i = 0; i < recenTransactions.length; i++) {
        if (recenTransactions[i].date.day == weekDay.day &&
            recenTransactions[i].date.month == weekDay.month &&
            recenTransactions[i].date.year == weekDay.year) {
          totalSum = totalSum + recenTransactions[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      }; //use to convert into string and monday to m etc
    }).reversed.toList();
    //so thatfirst chart is sunday than monday and so on
  }

  double get totalspending {
    return groupedTransactionvalues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    }); //fold convert list to another type that we want to
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment
                .spaceAround, //use to give spacing btw chartbar
            children: groupedTransactionvalues.map((data) {
              return Flexible(
                  fit: FlexFit
                      .tight, //use so that chart bar dont take extra values and use its own space only

                  child: ChartBar(
                      data['day'],
                      data['amount'],
                      totalspending == 0.0
                          ? 0.0
                          : (data['amount'] as double) / totalspending));
            }).toList(),
          )),
    );
  }
}
