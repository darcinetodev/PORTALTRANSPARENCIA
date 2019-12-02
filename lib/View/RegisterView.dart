import 'package:flutter/material.dart';
import 'package:portaltransparencia/Controller/RegisterUserController.dart';
import 'package:portaltransparencia/View/Helper/InputField.dart';
import 'package:portaltransparencia/View/WaitView.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  RegisterUserController _registerUserController = new RegisterUserController();

  @override
  void initState() {
    super.initState();

    _registerUserController.outState.listen((state) {
      switch (state) {
        case RegisterUserState.SUCESS:
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => WaitView()));
          break;
        case RegisterUserState.FAIL:
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text('Erro'),
                    content: Text('E-mail já cadastrado.'),
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
          stream: _registerUserController.outState,
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
                        height: MediaQuery.of(context).size.height / 4,
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
                                  obscure: false,
                                  stream: _registerUserController.outName,
                                  onChanged: _registerUserController.changeName
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
                                  obscure: false,
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
                                  obscure: false,
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
                                  obscure: false,
                                  stream: _registerUserController.outEmail,
                                  onChanged: _registerUserController.changeEmail,
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
                                  obscure: true,
                                  stream: _registerUserController.outPassword,
                                  onChanged: _registerUserController.changePassword,
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
                                  hint: 'Digite o CNPJ do condominio',
                                  obscure: false,
                                  stream: _registerUserController.outCondominium,
                                  onChanged: _registerUserController.changeCondominium
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
