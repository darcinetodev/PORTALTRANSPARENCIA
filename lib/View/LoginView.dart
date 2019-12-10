import 'package:flutter/material.dart';
import 'package:portaltransparencia/Controller/LoginController.dart';
import 'package:portaltransparencia/View/Helper/InputField.dart';
import 'package:portaltransparencia/View/HomeView.dart';
import 'package:portaltransparencia/View/RegisterView.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        case LoginState.REGISTER:
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

    double defaultScreenWidth = 400.0;
    double defaultScreenHeight = 810.0;
    ScreenUtil.instance = ScreenUtil(
      width: defaultScreenWidth,
      height: defaultScreenHeight,
      allowFontScaling: true,
    )..init(context);

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
                          bottomRight: Radius.circular(200)
                        )
                      ),
                      child: Icon(
                        Icons.account_circle,
                        color: Colors.white,
                        size: 120,
                      )
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: ScreenUtil.instance.width / 10),
                      child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(top: 70, bottom: 5),
                              child: GestureDetector(
                                child:
                                    Text('Ainda não é cadastrado? cadastre-se!',
                                        style: TextStyle(fontSize: ScreenUtil.instance.setSp(14.0))),
                                onTap: () {
                                  _loginController.registerStatus();
                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context)=>RegisterView())
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: InputField(
                                hint: 'Digite seu e-mail',
                                input: TextInputType.emailAddress,
                                obscure: false,
                                stream: _loginController.outEmail,
                                onChanged: _loginController.changeEmail,
                                fontSize: ScreenUtil.instance.setSp(16.0),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: InputField(
                                hint: 'Digite sua senha',
                                obscure: true,
                                stream: _loginController.outPassword,
                                onChanged: _loginController.changePassword,
                                fontSize: ScreenUtil.instance.setSp(16.0),
                              ),
                            ),
                            Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.all(Radius.circular(50))),
                                child: StreamBuilder<bool>(
                                  stream: _loginController.outSubmitValid,
                                  builder: (context, snapshot) {
                                    return FlatButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50.0)),
                                      child: Text('Logar',
                                                  style: TextStyle(
                                                    fontSize: ScreenUtil.instance.setSp(16.0),
                                                    color: Colors.white
                                                  )
                                                ),
                                      onPressed: snapshot.hasData ? _loginController.submit : null,
                                    );
                                  },
                                ),
                              )
                          ],
                        )
                    )
                  ]
                )
              );
          }
        }
      )
    );
  }
}
