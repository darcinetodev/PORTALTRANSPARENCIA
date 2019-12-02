import 'package:flutter/material.dart';
import 'package:portaltransparencia/Controller/HomeController.dart';
import 'package:portaltransparencia/Controller/NewsController.dart';
import 'package:portaltransparencia/Model/NewsModel.dart';

class NewsView extends StatefulWidget {
  @override
  _NewsViewState createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  NewsController _newsController = new NewsController();
  HomeController _homeController = new HomeController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<NewsModel>>(
      stream: _newsController.outNews,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();

        return Container(
          child: ListView(
            children: snapshot.data.map((news) {
              return StreamBuilder<int>(
                stream: _homeController.outPass,
                builder: (context, snapshot) {
                  return snapshot.data == 1 ? Dismissible(
                    key: Key(news.documentId()),
                    onDismissed: (direction) {
                      _newsController.delete(news.documentId());
                  },
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white
                      ),
                      child: ListTile(
                        title: Text(news.title),
                        subtitle: Text(news.desc)
                      ),
                    ),
                  )
                ) : Padding(
                      padding: EdgeInsets.all(10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white
                        ),
                        child: ListTile(
                          title: Text(news.title),
                          subtitle: Text(news.desc)
                        ),
                      ),
                    );
                }
              );
            }).toList()
          )
        );
      });
  }
}