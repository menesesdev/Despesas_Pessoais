import 'dart:ui';

import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  //const TransactionList({super.key});

  final List<Transaction> transactions;
  final void Function(String) onRemove;

  TransactionList(this.transactions, this.onRemove);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (ctx, index) {
        final tr = transactions[index];
        return Card(
          margin: EdgeInsets.symmetric(
            horizontal: 6,
            vertical: 5,
          ),
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: FittedBox(
                  child: Column(
                    children: [
                      Text('${tr.value}'),
                    ],
                  ),
                ),
              ),
            ),
            title: Text(
              tr.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              DateFormat('d MMM y').format(tr.date),
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            trailing: IconButton(
              onPressed: () => onRemove(tr.id),
              color: Colors.red[500],
              icon: Icon(Icons.delete),
            ),
          ),
        );
      },
    );
  }
}
