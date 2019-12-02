import 'package:flutter/material.dart';
import 'package:portaltransparencia/Controller/HomeController.dart';
import 'package:portaltransparencia/Model/NewsModel.dart';
import 'package:portaltransparencia/View/LoginView.dart';
import 'package:portaltransparencia/View/NewAddView.dart';
import 'package:portaltransparencia/View/NewsView.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeController _homeController = new HomeController();
  final newsModel = new NewsModel();

  @override
  void initState() {
    super.initState();

    _homeController.outState.listen((state) {
      switch (state) {
        case HomeState.LOGOUT:
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => LoginView()));
          break;
        case HomeState.SUCESS:
        case HomeState.FAIL:
        case HomeState.IDLE:
        case HomeState.LOADING:
      }
    });
  }

  @override
  void dispose() {
    _homeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: StreamBuilder<String>(
          stream: _homeController.outDrawerTitle,
          builder: (context, snapshot) {
            return snapshot.hasData ? Text(snapshot.data) : Text('Home');
          }
        ),
      ),
      backgroundColor: Colors.blue,
      body: StreamBuilder<Widget>(
        stream: _homeController.outDrawer,
        builder: (context, snapshot) {
          return snapshot.hasData ? snapshot.data : NewsView();
        }
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: StreamBuilder<String>(
                stream: _homeController.outName,
                builder: (context, snapshot) {
                  return Text(snapshot.data != null ? snapshot.data : 'Carregando!');
                }
              ),
              accountEmail: StreamBuilder<String>(
                stream: _homeController.outEmail,
                builder: (context, snapshot) {
                  return Text(snapshot.data != null ? snapshot.data : 'Carregando!');
                }
              ),
              currentAccountPicture: CircleAvatar(
                backgroundColor:
                    Theme.of(context).platform == TargetPlatform.iOS
                        ? Colors.blue
                        : Colors.white,
                child: StreamBuilder<String>(
                  stream: _homeController.outName,
                  builder: (context, snapshot) {
                    return Text(
                      snapshot.data != null ? snapshot.data.substring(0, 1) : 'C',
                      style: TextStyle(fontSize: 40.0),
                    );
                  }
                ),
              ),
            ),
            InkWell(
              child: ListTile(
                title: Text("Home"),
                trailing: Icon(Icons.arrow_forward),
              ),
              onTap: () {
                _homeController.changeDrawer(NewsView());
                _homeController.changeDrawerTitle('Home');
                Navigator.pop(context);
              }
            ),
            StreamBuilder<int>(
              stream: _homeController.outPass,
              builder: (context, snapshot) {
                return snapshot.data == 0 ? Container() : InkWell(
                  child: ListTile(
                    title: Text("Cadastrar Noticia"),
                    trailing: Icon(Icons.arrow_forward),
                  ),
                  onTap: () {
                    _homeController.changeDrawer(NewAddView(newsModel));
                    _homeController.changeDrawerTitle('Cadastrar Noticia');
                    Navigator.pop(context);
                  }
                );
              }
            ),
            InkWell(
              child: ListTile(
                title: Text("Votações"),
                trailing: Icon(Icons.arrow_forward),
              ),
              onTap: () {}
            ),
            InkWell(
              child: ListTile(
                title: Text("Reclamações"),
                trailing: Icon(Icons.arrow_forward),
              ),
              onTap: () {}
            ),
            Divider(),
            StreamBuilder(
              builder: (context, snapshot) {
                return InkWell(
                  child: ListTile(
                    title: Text("Sair"),
                    trailing: Icon(Icons.arrow_forward),
                  ),
                  onTap: _homeController.logout
                );
              }
            )
          ],
        ),
      ),
    );
  }
}