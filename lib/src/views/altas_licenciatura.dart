import 'package:flutter/material.dart';
import 'package:practicum/src/bloc/licenciaturas_bloc.dart';
import 'package:practicum/src/bloc/provider.dart';
import 'package:practicum/src/models/licenciaturas_models.dart';

import 'package:practicum/src/utils/utils.dart' as utils;

class AltasLicenciatura extends StatefulWidget{ 
static final String routeName = 'licenciatura';
  @override
  _PaginaLicenciatura createState() => _PaginaLicenciatura();
}

class _PaginaLicenciatura extends State<AltasLicenciatura> {
  
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey     = GlobalKey<FormState>();
  
  LicenciaturasBloc licenciaturasBloc;
  LicenciaturaModel licenciatura = new LicenciaturaModel();
  
  bool _guardando = false;
  bool _habilitar = true;
  
  @override
  Widget build(BuildContext context) {
    licenciaturasBloc = Provider.licenciaturasBloc(context);
    final LicenciaturaModel licenData = ModalRoute.of(context).settings.arguments;
    
    if ( licenData != null ) {
      licenciatura = licenData;
      _habilitar = false;
    }

    return Scaffold( 
      key: scaffoldKey,
      appBar: AppBar(
        //title: Text("Licenciaturas"),
        title: Text("Licenciaturas", style: TextStyle(color: Colors.blue)),
        iconTheme: new IconThemeData(color: Colors.blue),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),

      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          
          child: Form(
            key: formKey,
            //autovalidate: true,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              
              children: <Widget>[
                SizedBox(height: 24.0,),
                _crearClaveLic(),
                SizedBox(height: 24.0,),
                _crearNombre(),
                SizedBox(height: 24.0,),
                _crearDisponible(),
                SizedBox(height: 24.0,),
                _crearBotomRegistrar(),          
              ],
            ),
          ),          
        ),        
      ),
    );
  }

  Widget _crearClaveLic(){
    return TextFormField(
      initialValue: licenciatura.claveLic.toString(),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        filled: _habilitar,
        icon: Icon(Icons.navigate_next),
        hintText: 'Clave licenciatura',
        labelText: 'Clave licenciatura *',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
      ),
      enabled: _habilitar,
      onSaved: (value) => licenciatura.claveLic = int.parse(value),
      validator: (value) {
        if ( utils.isNumeric(value)  ) {
          return null;
        } else {
          return 'Sólo números';
        }
      },
      
      keyboardType: TextInputType.number,
    );
  }

  Widget _crearNombre(){
    return TextFormField(
      initialValue: licenciatura.nombre,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        filled: true,
        icon: Icon(Icons.book),
        hintText: 'Ingrese el nombre a registrar',
        labelText: 'Nombre *',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
      ),

      onSaved: (value) => licenciatura.nombre = value,
      validator: (value) {
        if ( value.length < 3 || !value.isNotEmpty) {
          return 'Ingrese un nombre valido.';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearDisponible() { 
    return SwitchListTile(
      value: licenciatura.activo,
      title: Text('Estado'),
      activeColor: Colors.blue,
      onChanged: (value)=> setState((){
        licenciatura.activo = value;  

        if (value) {
          mostrarSnackbar("¡Usuario activo!");
        }else{
          mostrarSnackbar("¡Usuario inactivo!");
        }    
      }),
    );
  }

  Widget _crearBotomRegistrar(){
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      color: Colors.blue,
      textColor: Colors.white,
      label: Text('Guardar'),
      icon: Icon( Icons.save ),
      onPressed: ( _guardando ) ? null : _submit,
    
    );
  }

  void _submit() async {
    if ( !formKey.currentState.validate() ) return;
    formKey.currentState.save();

    setState(() {_guardando = true; });

    if(_habilitar == true){
      licenciaturasBloc.agregarLicenciatura(licenciatura);
      mostrarSnackbar('¡Licenciatura registrada exitosamente!');
    }else{
      licenciaturasBloc.editarLicenciatura(licenciatura);
      mostrarSnackbar('¡Licenciatura modificada exitosamente!');
    }
    
    Navigator.pop(context);
  }

  void mostrarSnackbar(String mensaje) {
    final snackbar = SnackBar(
      content: Text( mensaje ),
      duration: Duration( milliseconds: 1500),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
  }
}