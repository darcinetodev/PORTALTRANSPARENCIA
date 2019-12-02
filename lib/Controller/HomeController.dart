import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:portaltransparencia/Helper/HomeHelper.dart';
import 'package:rxdart/rxdart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum HomeState {LOGOUT, IDLE, LOADING, SUCESS, FAIL}

class HomeController extends BlocBase with HomeHelper {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _nameController = BehaviorSubject<String>();
  final _cpfController = BehaviorSubject<String>();
  final _dateController = BehaviorSubject<String>();
  final _condominiumController = BehaviorSubject<String>();
  final _passController = BehaviorSubject<int>();

  final _stateController = BehaviorSubject<HomeState>();
  final _drawerController = BehaviorSubject<Widget>();
  final _drawerTitle = BehaviorSubject<String>();

  Stream<String> get outEmail => _emailController.stream;
  Stream<String> get outPassword => _passwordController.stream;
  Stream<String> get outCpf => _cpfController.stream;
  Stream<String> get outDate => _dateController.stream;
  Stream<String> get outCondominium => _condominiumController.stream;
  Stream<String> get outName => _nameController.stream;
  Stream<int> get outPass => _passController.stream;

  Stream<HomeState> get outState => _stateController.stream;
  Stream<Widget> get outDrawer => _drawerController.stream;
  Stream<String> get outDrawerTitle => _drawerTitle.stream;

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changeCpf => _cpfController.sink.add;
  Function(String) get changeDate => _dateController.sink.add;
  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changeCondominium => _condominiumController.sink.add;
  Function(String) get changeDrawerTitle => _drawerTitle.sink.add;

  void changeDrawer(Widget widget) {
    _drawerController.sink.add(widget);
  }

  HomeController() {
    FirebaseAuth.instance.onAuthStateChanged.listen((user) {
      if(user != null) {
        Firestore.instance.collection("dataPeople")
                          .document(user.uid).get()
                          .then((doc) {
                              _nameController.add(doc["name"]);
                              _passController.add(doc["pass"]);
                              _emailController.add(user.email);
                            }
                          );
        _stateController.add(HomeState.SUCESS);
      } else {
        _stateController.add(HomeState.FAIL);
      }
    });
  }

  void logout() {
    FirebaseAuth.instance.signOut();
    _stateController.add(HomeState.LOGOUT);
  }

  @override
  dispose() {
    _emailController.close();
    _passwordController.close();
    _stateController.close();
    _cpfController.close();
    _dateController.close();
    _condominiumController.close();
    _drawerController.close();
    _drawerTitle.close();
    _passController.close();
  }
  
}