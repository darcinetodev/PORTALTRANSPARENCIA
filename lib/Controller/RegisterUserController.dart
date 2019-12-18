import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:portaltransparencia/Helper/AuthRegister.dart';
import 'package:portaltransparencia/Helper/RegisterHelper.dart';
import 'package:rxdart/rxdart.dart';

enum RegisterUserState {IDLE, LOADING, SUCESS, FAIL}

class RegisterUserController extends BlocBase with RegisterUserHelper {

  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _nameController = BehaviorSubject<String>();
  final _cpfController = BehaviorSubject<String>();
  final _dateController = BehaviorSubject<DateTime>();
  final _condominiumController = BehaviorSubject<String>();
  final _stateController = BehaviorSubject<RegisterUserState>();

  Stream<String> get outEmail => _emailController.stream.transform(validateEmail);
  Stream<String> get outPassword => _passwordController.stream.transform(validatePassword);
  Stream<String> get outCpf => _cpfController.stream.transform(validateCpf);
  Stream<DateTime> get outDate => _dateController.stream.defaultIfEmpty(DateTime.now());
  Stream<String> get outCondominium => _condominiumController.stream;
  Stream<String> get outName => _nameController.stream;
  Stream<RegisterUserState> get outState => _stateController.stream;

  Stream<bool> get outRegisterValid => Observable.combineLatest4(
    outEmail, outPassword, outCpf, outDate, (a, b, c, d) => true
  );

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changeCpf => _cpfController.sink.add;
  Function(DateTime) get changeDate => _dateController.sink.add;
  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changeCondominium => _condominiumController.sink.add;

  createUser() async {

    _stateController.add(RegisterUserState.LOADING);

    AuthRegister(_cpfController.value,
                _dateController.value,
                _condominiumController.value,
                _nameController.value,
                _emailController.value,
                _passwordController.value)
      .registerFirebase().then((data) {
        data != null ? _stateController.add(RegisterUserState.SUCESS)
                     : _stateController.add(RegisterUserState.FAIL);

    });
  }

  @override
  dispose() async {
    await _emailController.drain();
    _emailController.close();
    await _passwordController.drain();
    _passwordController.close();
    await _nameController.drain();
    _nameController.close();
    await _cpfController.drain();
    _cpfController.close();
    await _dateController.drain();
    _dateController.close();
    await _condominiumController.drain();
    _condominiumController.close();
    await _stateController.drain();
    _stateController.close();
  }
  
}