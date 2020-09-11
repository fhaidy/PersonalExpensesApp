import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;
  TransactionList(this.transactions, this.onRemove);
  @override
  Widget build(BuildContext context) {
    print(transactions[0].title);
    return Container(
      height: 540,
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
                elevation: 4,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: FittedBox(
                        child: Text(
                          'R\$${transactions[index].value.toStringAsFixed(2)}',
                          style: Theme.of(context).primaryTextTheme.headline6,
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    transactions[index].title,
                    style: Theme.of(context).primaryTextTheme.headline5,
                  ),
                  subtitle: Text(
                    DateFormat('dd MMMM').format(transactions[index].date),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red[300]),
                    onPressed: () => onRemove(transactions[index].id),
                  ),
                ),
              ),
            ),
    );
  }
}
