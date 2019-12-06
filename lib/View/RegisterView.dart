import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
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
          Navigator.of(context).pushReplacement(
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
                        height: MediaQuery.of(context).size.height / 3.5,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(200),
                                bottomRight: Radius.circular(200))),
                        child: Icon(
                          Icons.add_circle_outline,
                          color: Colors.white,
                          size: 120,
                        )),
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              left: 30, right: 30, bottom: 10, top: MediaQuery.of(context).size.height / 20),
                          child: InputField(
                            hint: 'Digite seu nome completo',
                            obscure: false,
                            stream: _registerUserController.outName,
                            onChanged: _registerUserController.changeName
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 30, right: 30, bottom: 10),
                          child: InputField(
                                  hint: 'Digite seu CPF',
                                  obscure: false,
                                  input: TextInputType.number,
                                  stream: _registerUserController.outCpf,
                                  onChanged: _registerUserController.changeCpf,
                                ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 30, right: 30, bottom: 10),
                          child: Container(
                            height: 50,
                            child: Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                  child: FlatButton(
                                    color: Colors.black12,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      child: StreamBuilder<String>(
                                        stream: _registerUserController.outDate,
                                        builder: (context, snapshot) {
                                          return Text(snapshot.data,
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.black45
                                                      )
                                          );
                                        }
                                      ),
                                    ),
                                    onPressed: () {
                                      DatePicker.showDatePicker(context,
                                        showTitleActions: true,
                                        minTime: DateTime(2000, 1, 1),
                                        maxTime: DateTime(2022, 12, 31),
                                        onConfirm: (date) {
                                          _registerUserController.dateSet(date);
                                        },
                                        currentTime: DateTime.now(), locale: LocaleType.en);}
                                  ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 30, right: 30, bottom: 10),
                          child: InputField(
                                  hint: 'Digite seu e-mail',
                                  input: TextInputType.emailAddress,
                                  obscure: false,
                                  stream: _registerUserController.outEmail,
                                  onChanged: _registerUserController.changeEmail,
                                ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 30, right: 30, bottom: 10),
                          child: InputField(
                                  hint: 'Digite sua senha',
                                  obscure: true,
                                  stream: _registerUserController.outPassword,
                                  onChanged: _registerUserController.changePassword,
                                ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(left: 30, right: 30, bottom: 10),
                          child: InputField(
                                  hint: 'Digite o CNPJ do condominio',
                                  input: TextInputType.number,
                                  obscure: false,
                                  stream: _registerUserController.outCondominium,
                                  onChanged: _registerUserController.changeCondominium
                                ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 30, right: 30),
                          child: Container(
                            height: 50,
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
                                            fontSize: 18, color: Colors.white)),
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
