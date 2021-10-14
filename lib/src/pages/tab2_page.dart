import 'package:app_noticias_flutter/src/models/category_models.dart';
import 'package:app_noticias_flutter/src/services/news_service.dart';
import 'package:app_noticias_flutter/src/theme/tema.dart';
import 'package:app_noticias_flutter/src/widgets/lista_noticias.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Tab2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            _ListCategories(),
            Expanded(
                child: ListaNoticias(
                    newsService.getArticulosCategoriaSeleccionada!))
          ],
        ),
      ),
    );
  }
}

class _ListCategories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<NewsService>(context).categories;

    return Container(
      width: double.infinity,
      height: 80,
      child: ListView.builder(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (BuildContext context, int index) {
            final name = categories[index].name;
            return Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  _categoryButton(categories[index]),
                  SizedBox(height: 5),
                  Text('${name[0].toUpperCase()}${name.substring(1)}')
                ],
              ),
            );
          }),
    );
  }
}

class _categoryButton extends StatelessWidget {
  final Category categoria;

  const _categoryButton(this.categoria);

  @override
  Widget build(BuildContext context) {
    final newsService = Provider.of<NewsService>(context);
    return GestureDetector(
      onTap: () {
        final newsService = Provider.of<NewsService>(context, listen: false);
        newsService.selectedCategory = categoria.name;
      },
      child: Container(
        width: 40,
        height: 40,
        margin: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child: Icon(categoria.icon,
            color: (newsService.selectedCategory == categoria.name)
                ? Colors.red
                : Colors.black54),
      ),
    );
  }
}
