
import 'dart:async';

import 'package:practicum/src/bloc/validaciones.dart';
import 'package:rxdart/rxdart.dart';

class LoginBlock with Validaciones{
  final _identificadorController = BehaviorSubject<String>();
  final _passwordController      = BehaviorSubject<String>();

  Stream<String> get identificadorStream => _identificadorController.stream.transform( validarIdentificador );
  Stream<String> get passwordStream => _passwordController.stream.transform( validarPassword );
  Stream<bool> get formValidStream => 
    Observable.combineLatest2(identificadorStream, passwordStream, (e, p)  => true);

  Function(String) get changeIdentificador => _identificadorController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  String get identificador => _identificadorController.value;
  String get password => _passwordController.value;

  dispose(){
    _identificadorController?.close();
    _passwordController?.close();
  } 
}