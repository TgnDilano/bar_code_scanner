import 'package:bar_code_scanner/pages/remove_tpe.dart';
import 'package:bar_code_scanner/pages/history.dart';
import 'package:bar_code_scanner/pages/stock_history.dart';
import 'package:flutter/material.dart';

class history_screens extends StatefulWidget {
  const history_screens({super.key});

  @override
  State<history_screens> createState() => _history_screensState();
}

class _history_screensState extends State<history_screens> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor:Colors.green.shade500,
          title: Center(child: Text('History')),
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'Added',),
              Tab(text: 'Withdrawed',),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            stock_history(),
            History(),
          ],
        ),
      ),
    );
  }
}
