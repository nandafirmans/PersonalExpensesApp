import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses_app/widgets/adaptive_flat_button.dart';

class NewTransactionForm extends StatefulWidget {
  final Function addNewTransaction;

  NewTransactionForm({
    this.addNewTransaction,
  });

  @override
  _NewTransactionFormState createState() => _NewTransactionFormState();
}

class _NewTransactionFormState extends State<NewTransactionForm> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    print('NewTransactionState initState()');
  }

  @override
  void didUpdateWidget(NewTransactionForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('NewTransactionState didUpdateWidget()');
  }

  @override
  void dispose() {
    super.dispose();
    print('NewTransactionState dispose()');
  }

  void _onBtnAddPress() {
    final title = titleController.text;
    final amount = double.tryParse(amountController.text);

    if (title.isEmpty || amount <= 0 || _selectedDate == null) {
      showDialog(
        context: context,
        child: AlertDialog(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[Text("data invalid")],
          ),
        ),
      );
      return;
    }

    widget.addNewTransaction(title, amount, _selectedDate);

    Navigator.of(context).pop();
  }

  void _onDatePicked(DateTime pickedDate) {
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _showDatePicker() {
    final DateTime now = DateTime.now();

    showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year),
      lastDate: now,
    ).then(_onDatePicked);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10,
          bottom: MediaQuery.of(context).viewInsets.bottom + 10,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 15),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "title",
                  border: OutlineInputBorder(),
                ),
                controller: titleController,
                onSubmitted: (_) => _onBtnAddPress(),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 15),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "amount",
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                controller: amountController,
                onSubmitted: (_) => _onBtnAddPress(),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 8),
                    child: Text(
                      _selectedDate == null
                          ? "No Date Choosen!"
                          : "Picked Date: ${DateFormat.yMd().format(_selectedDate)}",
                    ),
                  ),
                  AdaptiveFlatButton(
                    "Choose Date",
                    onPressed: _showDatePicker,
                  )
                ],
              ),
            ),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).textTheme.button.color,
              onPressed: _onBtnAddPress,
              child: Text("Add Transaction"),
            )
          ],
        ),
      ),
    );
  }
}
