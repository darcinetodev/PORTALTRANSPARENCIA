import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:portaltransparencia/Helper/Auth.dart';
import 'package:portaltransparencia/Helper/LoginHelper.dart';
import 'package:rxdart/rxdart.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum LoginState {IDLE, LOADING, SUCESS, FAIL}

class LoginController extends BlocBase with LoginHelper {

  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _stateController = BehaviorSubject<LoginState>();
  final _uidController = BehaviorSubject<String>();

  Stream<String> get outEmail => _emailController.stream.transform(validateEmail);
  Stream<String> get outPassword => _passwordController.stream.transform(validatePassword);
  Stream<LoginState> get outState => _stateController.stream;
  Stream<String> get outuid => _uidController.stream;

  Stream<bool> get outSubmitValid => Observable.combineLatest2(
    outEmail, outPassword, (a, b) => true
  );

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  verification() async {
    Future<FirebaseUser> auth = Auth(null, null).autoLogin();
    auth.then((data) {
      _uidController.add(data.uid);
      _stateController.add(LoginState.SUCESS);
    }).catchError((e) => _stateController.add(LoginState.IDLE));
  }

  submit() async {
    _stateController.add(LoginState.LOADING);

    Future<AuthResult> auth = Auth(_emailController.value, _passwordController.value).authFirebase();
    auth.then((data) {
      _uidController.add(data.user.uid);
      _stateController.add(LoginState.SUCESS);
    }).catchError((e) => _stateController.add(LoginState.FAIL));
  }

  @override
  dispose() async {
    await _emailController.drain();
    _emailController.close();
    await _passwordController.drain();
    _passwordController.close();
    await _stateController.drain();
    _stateController.close();
    await _uidController.drain();
    _uidController.close();
  }
  
}