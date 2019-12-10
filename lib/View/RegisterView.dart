import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:portaltransparencia/Controller/RegisterUserController.dart';
import 'package:portaltransparencia/View/Helper/InputField.dart';
import 'package:portaltransparencia/View/WaitView.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:date_format/date_format.dart';

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

    double defaultScreenWidth = 400.0;
    double defaultScreenHeight = 810.0;
    ScreenUtil.instance = ScreenUtil(
      width: defaultScreenWidth,
      height: defaultScreenHeight,
      allowFontScaling: true,
    )..init(context);

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
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: ScreenUtil.instance.width / 10),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(bottom: 10, top: MediaQuery.of(context).size.height / 20),
                            child: InputField(
                              hint: 'Digite seu nome completo',
                              obscure: false,
                              stream: _registerUserController.outName,
                              onChanged: _registerUserController.changeName,
                              fontSize: ScreenUtil.instance.setSp(14.0),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(bottom: 10),
                            child: InputField(
                                    hint: 'Digite seu CPF',
                                    input: TextInputType.number,
                                    obscure: false,
                                    stream: _registerUserController.outCpf,
                                    onChanged: _registerUserController.changeCpf,
                                    fontSize: ScreenUtil.instance.setSp(14.0)
                                  ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(bottom: 10),
                            child: Container(
                              height: 50,
                              child: Container(
                                    height: 50,
                                    width: MediaQuery.of(context).size.width,
                                    child: StreamBuilder<DateTime>(
                                      stream: _registerUserController.outDate,
                                      builder: (context, snapshot) {
                                        return FlatButton(
                                          color: Colors.black12,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
                                          child: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(snapshot.hasData ? formatDate(snapshot.data, [dd, '/', mm, '/', yyyy])
                                                                         : formatDate(DateTime.now(), [dd, '/', mm, '/', yyyy]),
                                                          style: TextStyle(
                                                            fontSize: ScreenUtil.instance.setSp(14.0),
                                                            color: Colors.black45
                                                        )
                                                      )
                                                  ),
                                          onPressed: () {
                                            DatePicker.showDatePicker(context,
                                              showTitleActions: true,
                                              minTime: DateTime(1900, 1, 1),
                                              maxTime: DateTime.now(),
                                              onConfirm: (date) {
                                                _registerUserController.changeDate(date);
                                              },
                                              currentTime: snapshot.data, locale: LocaleType.pt);
                                          }
                                        );
                                      }
                                    ),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(bottom: 10),
                            child: InputField(
                                    hint: 'Digite seu e-mail',
                                    input: TextInputType.emailAddress,
                                    obscure: false,
                                    stream: _registerUserController.outEmail,
                                    onChanged: _registerUserController.changeEmail,
                                    fontSize: ScreenUtil.instance.setSp(14.0)
                                  ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(bottom: 10),
                            child: InputField(
                                    hint: 'Digite sua senha',
                                    obscure: true,
                                    stream: _registerUserController.outPassword,
                                    onChanged: _registerUserController.changePassword,
                                    fontSize: ScreenUtil.instance.setSp(14.0)
                                  ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(bottom: 10),
                            child: InputField(
                                    hint: 'Digite o CNPJ do condominio',
                                    input: TextInputType.number,
                                    obscure: false,
                                    stream: _registerUserController.outCondominium,
                                    onChanged: _registerUserController.changeCondominium,
                                    fontSize: ScreenUtil.instance.setSp(14.0)
                                  ),
                          ),
                          Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              child: StreamBuilder<bool>(
                                  stream: _registerUserController.outRegisterValid,
                                  builder: (context, snapshot) {
                                    return FlatButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50.0)),
                                      child: Text('Cadastrar-se',
                                          style: TextStyle(
                                              fontSize: ScreenUtil.instance.setSp(14.0), color: Colors.white)),
                                      onPressed: snapshot.hasData
                                          ? _registerUserController.createUser
                                          : null,
                                    );
                                  }),
                            )
                        ],
                      ),
                    )
                  ],
                ));
            }
          }),
    );
  }
}
