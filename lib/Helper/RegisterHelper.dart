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

  final validateDate = StreamTransformer<String, String>.fromHandlers(
    handleData: (date, sink){
      if(date.length == 10){
        if((date.substring(2, 3).contains('/') && int.parse(date.substring(0, 2)) < 32 &&
           (date.substring(5, 6).contains('/')) && int.parse(date.substring(3, 5)) < 13))
          sink.add(date);
        else
          sink.addError('Insira uma data válida!');
      } else {
        sink.addError('Insira uma data válida!');
      }
    }
  );

}