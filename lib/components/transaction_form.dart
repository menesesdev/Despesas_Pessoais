import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  //const TransactionForm({super.key});

  final titleController = TextEditingController();
  final valueController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final title = titleController.text;
    final value = double.tryParse(valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    }
    widget.onSubmit(title, value, _selectedDate);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: titleController,
              onSubmitted: (_) => _submitForm(),
              decoration: InputDecoration(
                labelText: 'Título',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitForm(),
                controller: valueController,
                decoration: InputDecoration(
                  labelText: 'Valor - R\$',
                ),
              ),
            ),
            Container(
              height: 40,
              child: Row(
                children: <Widget>[
                  TextButton(
                    onPressed: _showDatePicker,
                    child: Text('Selecionar Data'),
                  ),
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'Nenhuma data selecionada!'
                          : DateFormat('dd/MM/y').format(_selectedDate),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.purple,
                    primary: Colors.white,
                  ),
                  onPressed: _submitForm,
                  child: Text('Adicionar'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
