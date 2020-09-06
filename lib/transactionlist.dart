import 'package:flutter/material.dart';
import './transaction.dart';
import './newtransaction.dart';
import 'package:intl/intl.dart'; //for date format

class TransactionList extends StatelessWidget {
  final List<transaction> transactions;
  final Function deletetx;

  TransactionList(this.transactions,this.deletetx);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 350,
        child: transactions.isEmpty
            ? Column(
                children: [
                  Text(
                    "NO TRANSACTIONS ADDED YET!",
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(
                    height: 10, //to give spacing between text and image.
                  ),
                  Container(
                      height: 150,
                      child: Image.asset(
                        'fonts/image/dark.jfif',
                        fit: BoxFit.cover,
                      )),
                ],
              )
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    child: ListTile(
                      //flutter materail app give this widget we can also built our custom widget
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: EdgeInsets.all(6),
                          child: FittedBox(
                            child: Text('Rs '+'${transactions[index].amount}'),
                          ),
                        ),
                      ),
                      title: Text(
                        transactions[index].title,
                        style: Theme.of(context).textTheme.title,
                      ),
                      subtitle: Text(
                        DateFormat.yMMMd().format(transactions[index].date),
                      ),
                      trailing: IconButton(icon: Icon(Icons.delete),color: Theme.of(context).errorColor,onPressed: ()=> deletetx(transactions[index].id),),
                    ),
                  );
                },
                itemCount: transactions.length,
              ));
  }
}





















