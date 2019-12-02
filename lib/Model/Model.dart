import 'package:cloud_firestore/cloud_firestore.dart';

abstract class Model {
  Model();  
  
  Model.fromMap(DocumentSnapshot document);
  toMap();  
  String documentId();    
}