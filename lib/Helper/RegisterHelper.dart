import 'dart:async';

class RegisterUserHelper {

  final validateEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink){
      if(email.contains('@')){
        sink.add(email);
      } else {
        sink.addError('Insira um e-mail válido!');
      }
    }
  );
  
  final validatePassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink){
      if(password.length >= 6){
        sink.add(password);
      } else {
        sink.addError('Insira uma senha válida!');
      }
    }
  );

  final validateCpf = StreamTransformer<String, String>.fromHandlers(
    handleData: (cpf, sink){
      if(cpf.length == 11){
        sink.add(cpf);
      } else {
        sink.addError('Insira um cpf válido!');
      }
    }
  );
}