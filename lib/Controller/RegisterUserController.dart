import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:portaltransparencia/Helper/RegisterHelper.dart';
import 'package:rxdart/rxdart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum RegisterUserState {IDLE, LOADING, SUCESS, FAIL}

class RegisterUserController extends BlocBase with RegisterUserHelper {

  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _nameController = BehaviorSubject<String>();
  final _cpfController = BehaviorSubject<String>();
  final _dateController = BehaviorSubject<String>();
  final _condominiumController = BehaviorSubject<String>();
  final _stateController = BehaviorSubject<RegisterUserState>();

  Stream<String> get outEmail => _emailController.stream.transform(validateEmail);
  Stream<String> get outPassword => _passwordController.stream.transform(validatePassword);
  Stream<String> get outCpf => _cpfController.stream.transform(validateCpf);
  Stream<String> get outDate => _dateController.stream.transform(validateDate);
  Stream<String> get outCondominium => _condominiumController.stream;
  Stream<String> get outName => _nameController.stream;
  Stream<RegisterUserState> get outState => _stateController.stream;

  Stream<bool> get outRegisterValid => Observable.combineLatest4(
    outEmail, outPassword, outCpf, outDate, (a, b, c, d) => true
  );

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changeCpf => _cpfController.sink.add;
  Function(String) get changeDate => _dateController.sink.add;
  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changeCondominium => _condominiumController.sink.add;

  Future createUser() async {
    final cpf = _cpfController.value;
    final date = _dateController.value;
    final condominium = _condominiumController.value;
    final name = _nameController.value;
    final email = _emailController.value;
    final password = _passwordController.value;

    _stateController.add(RegisterUserState.LOADING);

    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password)
      .catchError((e) => _stateController.add(RegisterUserState.FAIL));
    
    FirebaseAuth.instance.onAuthStateChanged.listen((user) async {
      _stateController.add(RegisterUserState.SUCESS);
      
      await Firestore.instance.collection("dataPeople")
        .document(user.uid).setData({"name" : name, "cpf" : cpf, "date" : date, "condominium" : condominium, "active" : 0, "pass" : 0})
        .catchError((e) => _stateController.add(RegisterUserState.FAIL));
    });
    
    await FirebaseAuth.instance.signOut();
  }

  @override
  dispose() {
    _emailController.close();
    _passwordController.close();
    _nameController.close();
    _cpfController.close();
    _dateController.close();
    _condominiumController.close();
    _stateController.close();
  }
  
}