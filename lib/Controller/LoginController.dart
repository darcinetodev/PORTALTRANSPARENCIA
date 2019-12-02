import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:portaltransparencia/Helper/LoginHelper.dart';
import 'package:rxdart/rxdart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum LoginState {IDLE, LOADING, SUCESS, FAIL}

class LoginController extends BlocBase with LoginHelper {

  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _stateController = BehaviorSubject<LoginState>();

  Stream<String> get outEmail => _emailController.stream.transform(validateEmail);
  Stream<String> get outPassword => _passwordController.stream.transform(validatePassword);
  Stream<LoginState> get outState => _stateController.stream;

  Stream<bool> get outSubmitValid => Observable.combineLatest2(
    outEmail, outPassword, (a, b) => true
  );

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  LoginController() {
    FirebaseAuth.instance.onAuthStateChanged.listen((user) {
      if(user != null) {
        Firestore.instance.collection("dataPeople")
                          .document(user.uid).get()
                          .then((active) {
                            if(active.data["active"] == 1)
                              _stateController.add(LoginState.SUCESS);
                            else {
                              _stateController.add(LoginState.FAIL);
                              FirebaseAuth.instance.signOut();
                            }
                          });
      } else {
        _stateController.add(LoginState.IDLE);
      }
    });
  }

  void submit() {
    final email = _emailController.value;
    final password = _passwordController.value;

    _stateController.add(LoginState.LOADING);

    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password
    ).catchError((e) {
      _stateController.add(LoginState.FAIL);
    });
  }

  @override
  dispose() {
    _emailController.close();
    _passwordController.close();
    _stateController.close();
  }
  
}