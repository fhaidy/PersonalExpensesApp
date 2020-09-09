import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  TransactionList(this.transactions);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: transactions.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Nenhuma Transação Cadastrada',
                    style: Theme.of(context).primaryTextTheme.headline5),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (ctx, index) => Card(
                  child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 2,
                      ),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'R\$ ${transactions[index].value.toStringAsFixed(2)}',
                      style: Theme.of(context).primaryTextTheme.headline6,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(transactions[index].title,
                          style: Theme.of(context).primaryTextTheme.bodyText1),
                      Text(
                        DateFormat('d MMMM y').format(transactions[index].date),
                        style: Theme.of(context).primaryTextTheme.subtitle1,
                      )
                    ],
                  ),
                ],
              )),
            ),
    );
  }
}
