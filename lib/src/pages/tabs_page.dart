import 'package:app_noticias_flutter/src/pages/tab1_page.dart';
import 'package:app_noticias_flutter/src/pages/tab2_page.dart';
import 'package:app_noticias_flutter/src/services/news_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => _NavegacionModel(),
        child: Scaffold(body: _Paginas(), bottomNavigationBar: _Navegacion()));
  }
}

class _Navegacion extends StatelessWidget {
  const _Navegacion({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);

    return BottomNavigationBar(
        onTap: (i) => navegacionModel.paginaActual = i,
        currentIndex: navegacionModel._paginaActual,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Para ti'),
          BottomNavigationBarItem(icon: Icon(Icons.public), label: 'Para ti')
        ]);
  }
}

class _Paginas extends StatelessWidget {
  const _Paginas({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavegacionModel>(context);

    return PageView(
      controller: navegacionModel.pageController,
      physics: NeverScrollableScrollPhysics(),
      children: [Tab1Page(), Tab2Page()],
    );
  }
}

class _NavegacionModel with ChangeNotifier {
  PageController _pageController = PageController();

  int _paginaActual = 0;

  int get paginaActual => this._paginaActual;
  set paginaActual(int valor) {
    this._paginaActual = valor;
    _pageController.animateToPage(valor,
        duration: Duration(milliseconds: 250), curve: Curves.bounceInOut);
    notifyListeners();
  }

  PageController get pageController => this._pageController;
}
