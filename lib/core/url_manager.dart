import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class UrlManager {

  UrlManager(this.url, this.context);

  BuildContext context;
  String url;

  bool checkValidURL() {
    return RegExp(r'^https?://(www\.)?[-a-zA-Z0-9@:%._+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_+.~#?&/=]*)$').hasMatch(url);
  }

  Future<List> getDataList() async {
    List data = [];

    Uri? uri = Uri.tryParse(url);
    if (uri == null) {
      return data;
    }
    final response = await http.get(uri);
    if (!context.mounted) return data;

    if (response.statusCode == 200) {
      try {
        final Map<String, dynamic> mapData = jsonDecode(response.body);

        if (mapData['error']) {
          return [];
        }

        data = mapData['data'];
      } catch (e) {
        return [];
      }
    }

    return data;
  }
}