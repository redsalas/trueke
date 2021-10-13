import 'package:flutter/material.dart';
import 'package:trueke/utilities/login_bloc.dart';

class UserProvider extends InheritedWidget {

  static UserProvider _instancia;
  factory UserProvider({ Key key, Widget child }) {
    if ( _instancia == null ) {
      _instancia = new UserProvider._internal(key: key, child: child );
    }
    return _instancia;
  }

  UserProvider._internal({ Key key, Widget child }) : super(key: key, child: child);
  final loginBloc = LoginBloc();

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static LoginBloc of ( BuildContext context ) {
    return context.dependOnInheritedWidgetOfExactType<UserProvider>().loginBloc;
  }

}