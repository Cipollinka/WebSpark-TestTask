import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_task/core/url_manager.dart';
import 'package:test_task/widgets/toast.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String link = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Home screen",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        )
      ),
      body: SafeArea(
          child: Padding(
            padding: EdgeInsetsGeometry.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Set valid API base URL in order to continue'),
                    Row(
                      children: [
                        const Icon(Icons.add_link),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            onChanged: (String text) => {
                              setState(() {
                                link = text;
                              })
                            },
                            obscureText: false,
                            decoration: const InputDecoration(
                              labelText: 'URL',
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),

                Spacer(),

                Center(
                  child: ElevatedButton(
                      onPressed: () {
                        UrlManager urlManager = UrlManager(link, context);
                        if (urlManager.checkValidURL()) {
                          Navigator.of(context).pushNamed('/process', arguments: urlManager);
                        } else {
                          Toast(context).show('Incorrect url enter');
                        }
                      },
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
                        'Start counting process',
                        style: TextStyle(
                          color: Colors.black
                        ),
                      ),
                  ),
                )
              ],
            )
          ),
      ),
    );
  }
}
