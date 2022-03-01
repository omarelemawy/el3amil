import 'package:flutter/material.dart';

class MoneyTransactionPage extends StatefulWidget {
  @override
  _MoneyTransactionPageState createState() => _MoneyTransactionPageState();
}

class _MoneyTransactionPageState extends State<MoneyTransactionPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("العملبيات المالية"),
        centerTitle: true,
      ),
      body: ListView.separated(
          itemBuilder: (context, index) => Center(
              child:
                  Text("طلب سحب رصيد 50ريال   بتاريخ 5 مايو 2015  الساعة 5 م")),
          separatorBuilder: (context, index) => Divider(
                indent: 10,
                endIndent: 10,
              ),
          itemCount: 20),
    );
  }
}
