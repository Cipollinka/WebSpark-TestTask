import 'package:flutter/material.dart';
import 'package:test_task/core/calculate.dart';
import 'package:test_task/widgets/dynamic_grid.dart';

class PreviewScreen extends StatelessWidget {
  const PreviewScreen({super.key});


  @override
  Widget build(BuildContext context) {

    Map<String, dynamic> data = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            title: Text("Preview screen",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            )
        ),
      body: SafeArea(
          child: Column(
            children: [
              DynamicGrid(data['grid'], data['path']),
              Center(
                child: Text(
                  Calculate().convertToString(data['path']),
                  style: TextStyle(fontSize: 20),
                ),
              )
            ],
          )
      ),
    );
  }
}
