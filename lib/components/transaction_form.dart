import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;
    if (title.isNotEmpty && value > 0 && _selectedDate != null)
      widget.onSubmit(title, value, _selectedDate);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value != null) {
        setState(() {
          _selectedDate = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Título'),
              onSubmitted: (_) => _submitForm(),
            ),
            TextField(
              controller: _valueController,
              decoration: InputDecoration(labelText: 'Valor R\$'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _submitForm(),
            ),
            Container(
              height: 70,
              child: Row(children: [
                Expanded(
                  child: Text(
                    _selectedDate == null
                        ? 'Nenhuma Data selecionada !'
                        : 'Data Selecionada: ${DateFormat('dd/MM/y').format(_selectedDate)}',
                  ),
                ),
                FlatButton(
                  onPressed: _showDatePicker,
                  child: Text(
                    'Alterar Data',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  textColor: Theme.of(context).primaryColor,
                )
              ]),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RaisedButton(
                  onPressed: _submitForm,
                  color: Theme.of(context).primaryColor,
                  child: Text('Nova Transação'),
                  textColor: Theme.of(context).primaryTextTheme.button.color,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
