import 'package:flutter/material.dart';
import 'package:portaltransparencia/Controller/LoginController.dart';
import 'package:portaltransparencia/View/Helper/InputField.dart';
import 'package:portaltransparencia/View/HomeView.dart';
import 'package:portaltransparencia/View/RegisterView.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  LoginController _loginController = new LoginController();

  @override
  void initState() {
    super.initState();

    _loginController.outState.listen((state) {
      switch(state) {
        case LoginState.SUCESS:
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context)=>HomeView())
          );
          break;
        case LoginState.FAIL:
          showDialog(context: context, builder: (context)=>AlertDialog(
            title: Text('Erro'),
            content: Text('E-mail ou senha incorretos.'),
          ));
          break;
        case LoginState.IDLE:
        case LoginState.LOADING:
      }
    });
  }
  
  @override
  void dispose() {
    _loginController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<LoginState>(
            stream: _loginController.outState,
            builder: (context, snapshot) {
              switch (snapshot.data) {
                case LoginState.LOADING:
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.blue),
                    ),
                  );
                case LoginState.FAIL:
                case LoginState.SUCESS:
                case LoginState.IDLE:
                default:
                  return SingleChildScrollView(
                      child: Column(
                    children: <Widget>[
                      Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 2.5,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(200),
                                  bottomRight: Radius.circular(200))),
                          child: Icon(
                            Icons.account_circle,
                            color: Colors.white,
                            size: 120,
                          )),
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 70, bottom: 5),
                            child: GestureDetector(
                              child:
                                  Text('Ainda não é cadastrado? cadastre-se!'),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterView()),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 15, right: 15, bottom: 20),
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              child: Padding(
                                padding: EdgeInsets.only(left: 15, right: 15),
                                child: Center(
                                  child: InputField(
                                    hint: 'Digite seu e-mail',
                                    stream: _loginController.outEmail,
                                    onChanged: _loginController.changeEmail,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 15, right: 15, bottom: 20),
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                  color: Colors.black12,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              child: Padding(
                                padding: EdgeInsets.only(left: 15, right: 15),
                                child: Center(
                                  child: InputField(
                                    hint: 'Digite sua senha',
                                    stream: _loginController.outPassword,
                                    onChanged:
                                        _loginController.changePassword,
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              child: StreamBuilder<bool>(
                                stream: _loginController.outSubmitValid,
                                builder: (context, snapshot) {
                                  return FlatButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50.0)),
                                    child: Text('Logar',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white)),
                                    onPressed: snapshot.hasData
                                        ? _loginController.submit
                                        : null,
                                  );
                                },
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ));
              }
            }));
  }
}
