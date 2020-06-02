import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

bool isNumeric( String s ) {
  if ( s.isEmpty ) return false;
  final n = num.tryParse(s);
  return ( n == null ) ? false : true;
}

void mostrarAlerta(BuildContext context, String mensaje, String titulo ) {
  showDialog(
    context: context,
    builder: ( context ) {
      return CupertinoAlertDialog(
        title: Text(titulo),
        content: Text(mensaje),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: ()=> Navigator.of(context).pop(),
          ),
          FlatButton(
            child: Text('Cancelar'),
            onPressed: ()=> Navigator.of(context).pop(),
          )
        ],
      );
    }
  );
}