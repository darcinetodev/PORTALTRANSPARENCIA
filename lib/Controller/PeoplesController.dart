import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:portaltransparencia/Helper/PeoplesHelper.dart';
import 'package:rxdart/rxdart.dart';

class PeoplesController extends BlocBase with PeoplesHelper {

  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  Stream<String> get outEmail => _emailController.stream.transform(validateEmail);
  Stream<String> get outPassword => _passwordController.stream.transform(validatePassword);

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  @override
  dispose() {
    _emailController.close();
    _passwordController.close();
  }
  
}