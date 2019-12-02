import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:portaltransparencia/Model/Model.dart';

class NewsModel implements Model {
  String _documentId;
  String title;
  String desc;
  String condominium;

  NewsModel();

  NewsModel.fromMap(DocumentSnapshot document) {
    _documentId = document.documentID;

    this.title = document.data["title"];
    this.desc = document.data["desc"];
    this.condominium = document.data["condominium"];
  }

  @override
  toMap() {
    var map = new Map<String, dynamic>();
    map['title'] = this.title;
    map['desc'] = this.desc;
    map['condominium'] = this.condominium;
    return map;
  }

  @override
  String documentId() => _documentId;
}