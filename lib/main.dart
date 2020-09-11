import 'dart:math';

import 'package:expenses/components/chart.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:flutter/material.dart';
import 'components/transaction_list.dart';
import 'models/transaction.dart';

main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: ThemeData(
        fontFamily: 'QuickSand',
        primarySwatch: Colors.green,
        accentColor: Colors.greenAccent,
        primaryTextTheme: TextTheme(
          bodyText1: TextStyle(
              fontSize: 20.0, fontFamily: 'QuickSand', color: Colors.black),
          bodyText2: TextStyle(
              fontSize: 12.0, fontFamily: 'QuickSand', color: Colors.black),
          headline5: TextStyle(
              fontSize: 20.0, color: Colors.black, fontFamily: 'QuickSand'),
          headline6: TextStyle(
              fontSize: 20.0, color: Colors.white, fontFamily: 'QuickSand'),
          subtitle1: TextStyle(
              fontSize: 16.0, color: Colors.grey, fontFamily: 'QuickSand'),
          button: TextStyle(color: Colors.white),
        ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final globalKey = GlobalKey<ScaffoldState>();
  final List<Transaction> _transactions = [
    //   Transaction(
    //     id: 't0',
    //     title: 'Old Bill',
    //     value: 310.76,
    //     date: DateTime.now().subtract(Duration(days: 33)),
    //   ),
    //   Transaction(
    //     id: 't1',
    //     title: 'New Shoes',
    //     value: 310.76,
    //     date: DateTime.now().subtract(Duration(days: 4)),
    //   ),
    //   Transaction(
    //     id: 't2',
    //     title: 'Energy Bill',
    //     value: 211.3,
    //     date: DateTime.now().subtract(Duration(days: 3)),
    //   ),
  ];

  List<Transaction> get _recentTransactions {
    return _transactions
        .where((transaction) => transaction.date
            .isAfter(DateTime.now().subtract(Duration(days: 7))))
        .toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final transaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );
    setState(() {
      _transactions.add(transaction);
    });
    Navigator.of(context).pop();

    globalKey.currentState.showSnackBar(SnackBar(
      content: Text('Despesa cadastrada'),
      duration: Duration(seconds: 2),
    ));
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((element) => element.id == id);
    });
    globalKey.currentState.showSnackBar(SnackBar(
      content: Text('Despesa removida'),
      duration: Duration(seconds: 2),
    ));
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => TransactionForm(_addTransaction),
      isDismissible: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    _transactions.sort((a, b) => a.date.compareTo(b.date));
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        title: Text('Despesas Pessoais'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _openTransactionFormModal(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(_recentTransactions),
            TransactionList(
                _transactions.reversed.toList(), _removeTransaction),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openTransactionFormModal(context),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
