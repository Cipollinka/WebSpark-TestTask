import 'package:flutter/material.dart';
import 'package:test_task/core/calculate.dart';

class ResultListScreen extends StatefulWidget {
  const ResultListScreen({super.key});

  @override
  State<ResultListScreen> createState() => _ResultListScreenState();
}

class _ResultListScreenState extends State<ResultListScreen> {

  Calculate calculate = Calculate();

  @override
  Widget build(BuildContext context) {


    List data = ModalRoute.of(context)!.settings.arguments as List;

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          title: Text("Result list screen",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          )
      ),
      body: SafeArea(
          child: Padding(
            padding: EdgeInsetsGeometry.all(10),
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed('/preview', arguments: data[index]);
                    },
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(calculate.convertToString(data[index]['path']), textAlign: TextAlign.center),
                        ),
                        Divider(
                          height: 1,
                        )
                      ],
                    )
                );
              },
            ),
          )
      ),
    );
  }
}
