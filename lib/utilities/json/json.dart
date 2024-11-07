import 'dart:convert';

import 'package:flutter/services.dart';

class JSON {
  static Future<dynamic> decode(String fileName) async {
    final String path = "assets/stubs/$fileName.json";
    final String data = await rootBundle.loadString(path);
    return await json.decode(data);
  }
}
