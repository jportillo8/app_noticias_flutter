import 'package:app_noticias_flutter/src/models/category_models.dart';
import 'package:app_noticias_flutter/src/models/news_models.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

// Endpoint https://newsapi.org/v2/top-headlines?country=co&apiKey=24524977aa8349a69948527793fc85de

final _URL_NEWS = 'newsapi.org';
final _API = '24524977aa8349a69948527793fc85de';

class NewsService with ChangeNotifier {
  List<Article> headlines = [];
  String _selectedCategory = 'business';
  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyballBall, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];

  Map<String, List<Article>> categoryArticles = {};

  NewsService() {
    this.getTopHeadlines();
    categories.forEach((element) {
      categoryArticles[element.name] = [];
    });
  }

  String get selectedCategory => _selectedCategory;
  set selectedCategory(String valor) {
    this._selectedCategory = valor;
    this.getArticlesByCategory(valor);
    notifyListeners();
  }

  List<Article>? get getArticulosCategoriaSeleccionada =>
      categoryArticles[this.selectedCategory];

  getTopHeadlines() async {
    final url = Uri.https(
        _URL_NEWS, '/v2/top-headlines', {'country': 'co', 'apiKey': _API});
    // print(url);
    final resp = await http.get(url);

    final newsResponse = newsResponseFromJson(resp.body);
    // print(newsResponse.articles[5].title);
    this.headlines.addAll(newsResponse.articles);
    notifyListeners();
  }

  getArticlesByCategory(String category) async {
    if (this.categoryArticles[category]!.length > 0) {
      return this.categoryArticles[category];
    }

    final url = Uri.https(_URL_NEWS, '/v2/top-headlines',
        {'country': 'co', 'apiKey': _API, 'category': category});
    // print(url);
    final resp = await http.get(url);

    final newsResponse = newsResponseFromJson(resp.body);
    categoryArticles[category]!.addAll(newsResponse.articles);
    notifyListeners();
  }
}
