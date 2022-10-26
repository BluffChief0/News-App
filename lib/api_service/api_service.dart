import 'dart:convert';
import 'package:http/http.dart';
import 'package:news_app/models/new.dart';

class ApiService {
  static Future<List<New>?> getAllArticles(int page) async {
    Response response = await get(Uri.parse(
        "https://newsapi.org/v2/everything?q=tesla&from=2022-09-25&sortBy=publishedAt&pageSize=15&&page=$page&apiKey=5f69523317a6481991dedb65241206b1"));
    if (response.statusCode == 200) {
      Map<String, dynamic> rawData = jsonDecode(response.body);
      List<dynamic> data = List<dynamic>.from(rawData['articles']);
      List<New> news = data.map((e) => New.fromJSON(e)).toList();
      return news;
    } else {
      return null;
    }
  }

  static Future<List<New>?> getTopArticles(int page) async {
    Response response = await get(Uri.parse(
        "https://newsapi.org/v2/top-headlines?q=tesla&from=2022-09-25&sortBy=publishedAt&pageSize=15&&page=$page&apiKey=5f69523317a6481991dedb65241206b1"));
    if (response.statusCode == 200) {
      Map<String, dynamic> rawData = jsonDecode(response.body);
      List<dynamic> data = List<dynamic>.from(rawData['articles']);
      List<New> news = data.map((e) => New.fromJSON(e)).toList();
      return news;
    } else {
      return null;
    }
  }
}
