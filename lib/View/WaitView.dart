import 'package:flutter/material.dart';
import 'package:portaltransparencia/View/LoginView.dart';

class WaitView extends StatefulWidget {
  @override
  _WaitViewState createState() => _WaitViewState();
}

class _WaitViewState extends State<WaitView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 2.1, bottom: 10),
              child: Text("Aguarde, sua conta será verificada pelo condominio.",
                          style: TextStyle(color: Colors.white),)),
            FlatButton(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0)),
              child: Text('Voltar',
              style: TextStyle(fontSize: 20, color: Colors.blue)),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context)=>LoginView()));
              }
            )
          ],
        ),
      )
    );
  }
}