import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:portaltransparencia/Controller/LoginController.dart';
import 'package:portaltransparencia/Helper/NewsHelper.dart';
import 'package:portaltransparencia/Model/NewsModel.dart';
import 'package:rxdart/rxdart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewsController extends BlocBase with NewsHelper {
  final _loginController = LoginController();
  final _newsController = BehaviorSubject<List<NewsModel>>();

  final _titleController = BehaviorSubject<String>();
  Stream<String> get outTitle => _titleController.stream;
  final _descController = BehaviorSubject<String>();
  Stream<String> get outDesc => _descController.stream;
  Stream<List<NewsModel>> get outNews => _newsController.stream;

  final _collection = Firestore.instance.collection("dataNews");

  String _documentId;
  String _title;
  String _desc;
  String _condominium;

  NewsController() {
    _titleController.listen((value) => _title = value);
    _descController.listen((value) => _desc = value);
    chargeNews();
    chargeCondominium();
  }

  void chargeCondominium() {
    _loginController.outuid.listen((user) => 
      Firestore.instance.collection("dataPeople").document(user).get().then((doc) {
        _condominium = doc["condominium"];
      })
    );
  }

  void chargeNews() {
    _loginController.outuid.listen((user) =>
      Firestore.instance.collection("dataPeople").document(user).get().then((doc) {
        Observable(_collection.where("condominium", isEqualTo: doc["condominium"])
          .snapshots().map((query) => query.documents
          .map<NewsModel>((document) => NewsModel.fromMap(document)
          ).toList())).listen((onData) => _newsController.add(onData));
      })
    );
  }

  void add(NewsModel newsModel) => _collection.add(newsModel.toMap());
  void update(String documentId, NewsModel newsModel) =>
      _collection.document(documentId).updateData(newsModel.toMap());
  void delete(String documentId) => _collection.document(documentId).delete();

  void setTitle(String value) => _titleController.sink.add(value);
  void setDesc(String value) => _descController.sink.add(value);
  void setNews(NewsModel newsModel) {
    _documentId = newsModel.documentId();

    setTitle(newsModel.title);
    setDesc(newsModel.desc);
  }

  bool insertOrUpdate() {
    var newsModel = NewsModel()
      ..title = _title
      ..desc = _desc
      ..condominium = _condominium;

    if (_documentId?.isEmpty ?? true) {
      add(newsModel);
    } else {
      update(_documentId, newsModel);
    }

    _titleController.add("");

    return true;
  }

  @override
  dispose() {
    _newsController.close();
    _titleController.close();
    _descController.close();
  }
  
}