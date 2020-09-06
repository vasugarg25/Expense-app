import 'package:flutter/material.dart';
import './transactionlist.dart';
import './transaction.dart';
import 'package:intl/intl.dart'; //for date format

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();
  DateTime selecteddate;

  void submitdata() {
    if (amountController.text.isEmpty)
      {
        return;
      }
    //print(amountInput);
    //print(titleInput);
    final enteredTitle = titleController.text;
    final enterredAmount = double.parse(amountController.text);
    if (enteredTitle.isEmpty || enterredAmount <= 0|| selecteddate==null) {
      return;
    }
    widget.addTx(titleController.text, double.parse(amountController.text),selecteddate);
    Navigator.of(context).pop(); //use to close bottom sheet itself
  }
void presentdatepicker(){
    showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2020), lastDate: DateTime.now()).then((pickedDate) {
      if(pickedDate==null)
        {
          return ;
        }
      setState(() {
        selecteddate=pickedDate;
      });

    });
}
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) => submitdata(),
            ),
            //  onChanged: (value) {
            //    titleInput = value;
            //  }),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitdata(),
            ),

            //  onChanged: (value) {
            //  amountInput = value;
            //},
            Container(
              height: 70,
              child:
Row(
  children: [
    Text(selecteddate==null?'NO DATE CHOSEN':'Picked Date: ${DateFormat.yMd().format(selecteddate)}'),
    FlatButton(textColor: Theme.of(context).primaryColor,
        onPressed: presentdatepicker,
      
     child: Text('CHOOSE DATE',))
  ],
),),
            FlatButton(
              onPressed: submitdata,
              child: Text('Add transaction'),
              color: Colors.red,
            )
          ],
        ),
      ),
    );
  }
}
