import 'package:flutter/material.dart';
import './transactionlist.dart';
import './transaction.dart';
import './newtransaction.dart';
import 'package:intl/intl.dart'; //for date format
import './chart.dart';

void main() {
  runApp(MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors
              .red, //we can use primary color also but it will not give different shade of that color and oor app can look bad!
          accentColor: Colors.amber,
          errorColor: Colors.purple,
          fontFamily: "Roboto",
          textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                fontFamily: "Roboto",
                fontSize: 15,
              )),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                      title: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: 20,
                  )))),
      home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<transaction> usertransaction = [];
  List<transaction> get recentTransactions {
    return usertransaction.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addusertransaction(
      String txtitle, double txamount, DateTime chosenDate) {
    final newtx = transaction(
        title: txtitle,
        amount: txamount,
        date:
            chosenDate, //we do this so that we can choose our date in calender
        id: DateTime.now().toString());
    setState(() {
      usertransaction.add(newtx);
    });
  }

  void _startaddnewtransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addusertransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void deletetransaction(String id) {
    setState(() {
      usertransaction.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("VASU EXPENSE"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () => _startaddnewtransaction(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Chart(recentTransactions),
            TransactionList(usertransaction, deletetransaction),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _startaddnewtransaction(context)),
    );
  }
}
