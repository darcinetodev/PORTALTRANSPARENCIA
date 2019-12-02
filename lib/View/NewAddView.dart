import 'package:flutter/material.dart';
import 'package:portaltransparencia/Controller/NewsController.dart';
import 'package:portaltransparencia/Model/NewsModel.dart';

class NewAddView extends StatefulWidget {
  NewAddView(this.newsModel);
  
  final NewsModel newsModel;

  @override
  _NewAddViewState createState() => _NewAddViewState();
}

class _NewAddViewState extends State<NewAddView> {
  final _newsController = NewsController();
  TextEditingController _titleController;
  TextEditingController _descController;

  @override
  void initState() {
    _newsController.setNews(widget.newsModel);
    
    _titleController = TextEditingController(text: widget.newsModel.title);
    _descController = TextEditingController(text: widget.newsModel.desc);
    super.initState();
  }

  @override
  void dispose() {
    _newsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20),
              child: Container(
                height: 120,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  child: Icon(Icons.add_circle,
                              color: Colors.white,
                              size: 100),
                  onTap: () {}
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 8),
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.all(Radius.circular(50))),
                child: Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                    child: Center(
                      child: TextField(
                        controller: _titleController,
                        onChanged: _newsController.setTitle,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Título'
                        ),
                        style: TextStyle(fontSize: 20)
                      ),
                    ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 8),
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.all(Radius.circular(50))),
                child: Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                    child: Center(
                      child: TextField(
                        controller: _descController,
                        onChanged: _newsController.setDesc,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Descrição'
                        ),
                        style: TextStyle(fontSize: 20)
                      ),
                    ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Container(
              height: 60,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(50))),
                child: FlatButton(
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0)),
                      child: Text('Adicionar',
                                  style: TextStyle(fontSize: 20, color: Colors.white)),
                      onPressed: () {
                        if (_newsController.insertOrUpdate())
                          Scaffold.of(context).showSnackBar(SnackBar(content: Text('Noticia cadastrada!')));
                        else
                          Scaffold.of(context).showSnackBar(SnackBar(content: Text('Erro ao cadastrar!')));
                        
                        setState(() {
                          _titleController.text = "";
                          _descController.text = "";
                        });
                      }
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}