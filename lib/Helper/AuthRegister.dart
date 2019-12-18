import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthRegister {

  String cpf;
  DateTime date;
  String condominium;
  String name;
  String email;
  String password;

  AuthRegister(cpf, date, condominium, name, email, password) {
    this.cpf = cpf;
    this.date = date;
    this.condominium = condominium;
    this.name = name;
    this.email = email;
    this.password = password;
  }

  Future<AuthResult> registerFirebase() async {
    AuthResult data;
    
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password)
      .then((result) => data = result)
      .catchError((e) => data = null);

    if (data != null)
      await Firestore.instance.collection("dataPeople")
        .document(data.user.uid)
        .setData({"name" : name, "cpf" : cpf, "date" : date, "condominium" : condominium, "active" : 0, "pass" : 0})
        .catchError((e) => data = null);
    
    await FirebaseAuth.instance.signOut();

    return data;
  }

}