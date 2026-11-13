import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_task/core/calculate.dart';
import 'package:test_task/core/grid.dart';
import 'package:test_task/core/point.dart';
import 'package:test_task/core/url_manager.dart';
import 'package:test_task/widgets/toast.dart';
import 'package:http/http.dart' as http;

import 'data/Params.dart';

class ProcessPage extends StatefulWidget {
  const ProcessPage({super.key});

  @override
  State<ProcessPage> createState() => _ProcessPageState();
}

class _ProcessPageState extends State<ProcessPage> {

  List data = [];
  List resultCalculateData = [];
  List dataForNextRoute = [];
  late UrlManager urlManager;
  Calculate calculate = Calculate();

  bool isLoading = true;
  double progressValue = 0.0;
  String statusText = "Get Data";


  List<List<String>> gridConverter(List field) {
    return field.map((row) => (row as String).split('').toList()).toList();
  }

  Future sendRequestToServer() async {
    setState(() {
      isLoading = true;
    });
    Uri uri = Uri.parse(Params.linkAPI);
    try {
      final response = await http.post(
        uri,
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(resultCalculateData)
      );
      if (response.statusCode == 200) {
        final responseJson = jsonDecode(response.body);
        if (responseJson['error']) {
          Toast(context).show('request error ${responseJson['message']}');
          return;
        }
        Navigator.of(context).pushNamed('/result', arguments: dataForNextRoute);
      }
    } catch (e) {
      Toast(context).show('request error ${e.toString()}');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  bool isInit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isInit) return;
    urlManager = ModalRoute.of(context)!.settings.arguments as UrlManager;
    getDataFromURL();

    isInit = true;
  }

  Future<void> processGrids() async {
    int total = data.length;
    if (total == 0) return;

    for (int i = 0; i < total; i++) {
      setState(() {
        progressValue = (i + 1) / total;
      });
      Grid grid = Grid(gridConverter(data[i]['field']));
      Point start = Point(data[i]['start']['x'], data[i]['start']['y']);
      Point end = Point(data[i]['end']['x'], data[i]['end']['y']);
      List<Point>? resultPath = calculate.findShortestPath(grid, start, end);
      String path = calculate.convertToString(resultPath!);
      List steps = calculate.convertToSteps(resultPath);
      setState(() {
        resultCalculateData.add({
          'id': data[i]['id'],
          'result': {
            "steps": steps,
            "path": path
          }
        });
        dataForNextRoute.add({
          'grid': grid,
          'path': resultPath
        });
      });
    }
  }

  Future<void> getDataFromURL() async {
    try {
      data = await urlManager.getDataList();

      await processGrids();

      setState(() {
        progressValue = 1.0;
        statusText = "All calculations has finished, you can send your results to server";
        isLoading = false;
      });

    } catch (e) {
      setState(() {
        isLoading = false;
        statusText = "Loading error: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          title: Text("Process Screen",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          )
      ),
      body: SafeArea(
          child: Padding(
            padding: EdgeInsetsGeometry.all(10),
            child: Column(
              children: [
                Spacer(),

                Text(statusText, textAlign: TextAlign.center,),

                SizedBox(height: 10),

                Text('${(progressValue * 100).toInt()}%'),

                SizedBox(height: 10),

                Center(
                  child: SizedBox(
                    width: 150,
                    height: 150,
                    child: CircularProgressIndicator(
                      value: progressValue,
                      strokeWidth: 5,
                      color: Colors.blue,
                    ),
                  ),
                ),

                Spacer(),

                ElevatedButton(
                  onPressed: isLoading ? null : sendRequestToServer,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue[400],
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      side: BorderSide(
                        color: CupertinoColors.systemBlue,
                        width: 1,
                      )
                  ),
                  child: Text(
                    'Send result to server',
                    style: TextStyle(
                        color: Colors.black
                    ),
                  ),
                ),
              ],
            ),
          ),
      ),
    );
  }
}
