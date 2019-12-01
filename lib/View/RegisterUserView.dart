import 'package:flutter/material.dart';
import 'package:portaltransparencia/Controller/RegisterUserController.dart';
import 'package:portaltransparencia/View/Helper/InputField.dart';
import 'package:portaltransparencia/View/HomeView.dart';

class RegisterUserView extends StatefulWidget {
  @override
  _RegisterUserViewState createState() => _RegisterUserViewState();
}

class _RegisterUserViewState extends State<RegisterUserView> {
  RegisterUserController _registerUserController = new RegisterUserController();

  @override
  void initState() {
    super.initState();

    _registerUserController.outState.listen((state) {
      switch (state) {
        case RegisterUserState.SUCESS:
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomeView()));
          break;
        case RegisterUserState.FAIL:
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text('Erro'),
                    content: Text('Algo não deu certo.'),
                  ));
          break;
        case RegisterUserState.IDLE:
        case RegisterUserState.LOADING:
      }
    });
  }

  @override
  void dispose() {
    _registerUserController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<Object>(
          stream: null,
          builder: (context, snapshot) {
            switch (snapshot.data) {
              case RegisterUserState.LOADING:
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.blue),
                  ),
                );
              case RegisterUserState.FAIL:
              case RegisterUserState.SUCESS:
              case RegisterUserState.IDLE:
              default:
                return SingleChildScrollView(
                    child: Column(
                  children: <Widget>[
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 6,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(200),
                                bottomRight: Radius.circular(200))),
                        child: Icon(
                          Icons.account_circle,
                          color: Colors.white,
                          size: 80,
                        )),
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              left: 15, right: 15, bottom: 8, top: 15),
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
                                  hint: 'Digite seu nome completo',
                                  stream: _registerUserController.outName,
                                  onChanged: _registerUserController.changeName,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 15, right: 15, bottom: 8),
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
                                  hint: 'Digite seu CPF',
                                  stream: _registerUserController.outCpf,
                                  onChanged: _registerUserController.changeCpf,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 15, right: 15, bottom: 8),
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
                                  hint: 'Digite sua data de nascimento',
                                  stream: _registerUserController.outDate,
                                  onChanged: _registerUserController.changeDate,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 15, right: 15, bottom: 8),
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
                                  stream: _registerUserController.outEmail,
                                  onChanged:
                                      _registerUserController.changeEmail,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 15, right: 15, bottom: 8),
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
                                  stream: _registerUserController.outPassword,
                                  onChanged:
                                      _registerUserController.changePassword,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 15, right: 15, bottom: 8),
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
                                  hint: 'Digite o id do seu condominio',
                                  stream:
                                      _registerUserController.outCondominium,
                                  onChanged:
                                      _registerUserController.changeCondominium,
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
                                stream:
                                    _registerUserController.outRegisterValid,
                                builder: (context, snapshot) {
                                  return FlatButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50.0)),
                                    child: Text('Cadastrar-se',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white)),
                                    onPressed: snapshot.hasData
                                        ? _registerUserController.createUser
                                        : null,
                                  );
                                }),
                          ),
                        )
                      ],
                    )
                  ],
                ));
            }
          }),
    );
  }
}
