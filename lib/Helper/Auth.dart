import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Auth {

  String email;
  String password;

  Auth(email, password) {
    this.email = email;
    this.password = password;
  }

  Future<AuthResult> authFirebase() async {
    AuthResult data;

    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password
    ).then((result) => data = result)
     .catchError((e) => data = null);

    return data != null ?
      await Firestore.instance.collection("dataPeople")
        .document(data.user.uid)
        .get()
        .then((doc) {
          return doc.data["active"] > 0 ? data : null;
      }).catchError((e) => null) : null;
  }

  Future<FirebaseUser> autoLogin() async {
    FirebaseUser data;

    await FirebaseAuth.instance.currentUser().then((result) => data = result)
      .catchError((e) => data = null);

    return data != null ?
      await Firestore.instance.collection("dataPeople")
        .document(data.uid)
        .get()
        .then((doc) {
          return doc.data["active"] > 0 ? data : null;
      }).catchError((e) => null) : null;
  }
}