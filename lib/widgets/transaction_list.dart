import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deletetx;

 
  const TransactionList(this.transactions,
      this.deletetx, {super.key}); 

  @override
  Widget build(BuildContext context) {
    return Container(
      
      child: transactions.isEmpty
          ? LayoutBuilder(
              builder: (p0, p1) {
                return Column(
                  children: <Widget>[
                    Text(
                      'NO TRASACTION ADDED YET',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),

                    ///ab title or image ke gap dena ha tw size box
                    SizedBox(
                      // child nhi hita
                      height: p1.maxHeight * 0.08,
                    ),
                    SizedBox(
                      height: p1.maxHeight * 0.6,
                      child: Image.asset(
                        'assets/image/waiting.png',
                        fit: BoxFit.cover,
                      ),
                    ),   
                  ],
                );
              },
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (ctx, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 5),
                  elevation: 5,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: FittedBox(
                        child: Text('\$${transactions[index].amount}'),
                      ),
                    ),
                    title: Text(transactions[index].title,
                        style: Theme.of(context).textTheme.titleLarge),
                    subtitle: Text(
                        DateFormat.yMMMMd().format(transactions[index].date)),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      color: Theme.of(context).colorScheme.error,
                      onPressed: () => deletetx(transactions[index].id),
                    ),
                  
                  ),
                );

               
              },
            ),
    );
  }
}

