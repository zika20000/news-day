import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newsday1/model/Silder_model.dart';

class silder {
  List<SilderModel> silders = [];
  Future<void> getsilder() async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=fbd5f6f47d504d08a77e61ab92b513fe";
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == "ok") {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          SilderModel silderModel = SilderModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
          );
          silders.add(silderModel);
        }
      });
    }
  }
}
