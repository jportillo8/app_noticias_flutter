import 'package:app_noticias_flutter/src/services/news_service.dart';
import 'package:app_noticias_flutter/src/widgets/lista_noticias.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Tab1Page extends StatefulWidget {
  @override
  State<Tab1Page> createState() => _Tab1PageState();
}

class _Tab1PageState extends State<Tab1Page>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    // return Scaffold(body: ListaNoticias(newsService.headlines));
    return Scaffold(
        body: (newsService.headlines.length == 0)
            ? Center(child: CircularProgressIndicator())
            : ListaNoticias(newsService.headlines));
  }

  @override
  // Este override me permite tener el esatdo de esta vista
  // Es decir que no va a ser destruida
  bool get wantKeepAlive => true;
}
