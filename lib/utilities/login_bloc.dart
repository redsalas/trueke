import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:trueke/utilities/validator.dart';

class LoginBloc with Validators {

  final _emailController    = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  //final _tokenController = BehaviorSubject<String>();

  // Recuperar los datos del Stream
  Stream<String> get emailStream    => _emailController.stream.transform( validateEmail );
  Stream<String> get passwordStream => _passwordController.stream.transform( validatePassword );
  //Stream<String> get tokenController => _tokenController.stream;

  Stream<bool> get formValidStream =>
      Observable.combineLatest2(emailStream, passwordStream, (e, p) => true );

  // Insertar valores al Stream
  Function(String) get changeEmail    => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;


  // Obtener el último valor ingresado a los streams
  String get email    => _emailController.value;
  String get password => _passwordController.value;
  //String get token => _tokenController.value;

  dispose() {
    _emailController?.close();
    _passwordController?.close();
    //_tokenController?.close();
  }

}
