import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:practicum/src/bloc/alumnos_bloc.dart';
import 'package:practicum/src/bloc/provider.dart';
import 'package:practicum/src/models/alumnos_models.dart';

import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:practicum/src/models/licenciaturas_models.dart';
import 'package:practicum/src/providers/licenciaturas_provider.dart';
import 'package:practicum/src/utils/utils.dart' as utils;

class AltasAlumno extends StatefulWidget {
  static final String routeName = 'alumnos';
  @override
  _PaginaAlumnos createState() => _PaginaAlumnos();
}

class _PaginaAlumnos extends State<AltasAlumno> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  AlumnosBloc alumnosBloc;
  AlumnoModel alumno = new AlumnoModel();
  final List<int> _semestre = <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];

  var _lic;
  var seleccion;

  bool _guardando = false;
  bool _habilitar = true;

  @override
  Widget build(BuildContext context) {
    alumnosBloc = Provider.alumnosBloc(context);
    
    final AlumnoModel alumData = ModalRoute.of(context).settings.arguments;
    if (alumData != null) {
      
      setState(() {
        alumno = alumData;
        _lic = alumno.licenciatura;
        seleccion = alumno.semestre;
        _habilitar = false;  
      });
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        //title: Text("Alumnos"),
        title: Text("Estudiantes", style: TextStyle(color: Colors.blue)),
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
                SizedBox(
                  height: 24.0,
                ),
                _crearMatriculo(),
                SizedBox(
                  height: 24.0,
                ),
                _crearNombre(),
                SizedBox(
                  height: 24.0,
                ),
                _crearApellidoPaterno(),
                SizedBox(
                  height: 24.0,
                ),
                _crearApellidoMaterno(),
                SizedBox(
                  height: 24.0,
                ),
                //_crearDropDownButtom(),
                //SizedBox(height: 24.0,),
                _crearDropDownButtomLista(),
                SizedBox(
                  height: 24.0,
                ),
                _crearDropDownButtonSemestre(_semestre),
                SizedBox(
                  height: 24.0,
                ),
                //_crearFechaNacimiento(),
                _crearEdad(),
                SizedBox(
                  height: 24.0,
                ),
                _crearEmail(),
                SizedBox(
                  height: 24.0,
                ),
                _crearDisponible(),
                SizedBox(
                  height: 24.0,
                ),
                _crearBotomRegistrar(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearMatriculo() {
    return TextFormField(
      initialValue: alumno.matricula.toString(),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        filled: _habilitar,
        icon: Icon(Icons.navigate_next),
        hintText: 'Matricula',
        labelText: 'Matricula *',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
      enabled: _habilitar,
      onSaved: (value) => alumno.matricula = int.parse(value),
      validator: (value) {
        if (utils.isNumeric(value)) {
          return null;
        } else {
          return 'Sólo números';
        }
      },
      keyboardType: TextInputType.number,
    );
  }

  Widget _crearNombre() {
    return TextFormField(
      initialValue: alumno.nombre,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        filled: true,
        icon: Icon(Icons.person),
        hintText: 'Ingrese el nombre a registrar',
        labelText: 'Nombre *',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
      onSaved: (value) => alumno.nombre = value,
      validator: (value) {
        if (value.trimLeft().length < 3 || value.isEmpty) {
          return 'Ingrese un nombre valido.';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearApellidoPaterno() {
    return TextFormField(
      initialValue: alumno.primerAp,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        filled: true,
        icon: Icon(Icons.queue),
        hintText: 'Apellido paterno',
        labelText: 'Apellido paterno *',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
      onSaved: (value) => alumno.primerAp = value,
      validator: (value) {
        if (value.trimLeft().length < 3 || value.isEmpty) {
          return 'Ingrese un apellido valido.';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearApellidoMaterno() {
    return TextFormField(
      initialValue: alumno.segundoAp,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        filled: true,
        icon: Icon(Icons.last_page),
        hintText: 'Apellido materno',
        labelText: 'Apellido materno *',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
      onSaved: (value) => alumno.segundoAp = value,
      validator: (value) {
        if (value.trimLeft().length < 3 || value.isEmpty) {
          return 'Ingrese un apellido valido.';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearFechaNacimiento() {
    String dato;

    final formato = DateFormat("yyyy-MM-dd");
    return DateTimeField(
      //initialValue: DateTime.parse(alumno.fechaNacimiento),
      keyboardType: TextInputType.datetime,
      decoration: InputDecoration(
        filled: true,
        icon: Icon(Icons.date_range),
        hintText: 'Fecha nacimiento *',
        labelText: 'Fecha de nacimiento *',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
      format: formato,
      onShowPicker: (context, currentValue) {
        return showDatePicker(
          context: context,
          firstDate: DateTime(1900),
          initialDate: currentValue ?? DateTime.now(),
          lastDate: DateTime(2030),
        );
      },
      //onChanged: (dt) => setState(() => dato = format.format(dt) as DateTime),
      //onSaved: (value) => alumno.fechaNacimiento = formato.format(value),
      validator: (value) {
        Pattern pattern =
            r'^\d{4}\-(0?[1-9]|1[012])\-(0?[1-9]|[12][0-9]|3[01])$';
        RegExp regExp = new RegExp(pattern);
        dato = formato.format(value);
        print(dato);
        if (regExp.hasMatch(dato) && dato.length == 10) {
          return null;
        } else {
          print(value);
          return ('Ingrese una fecha correcta');
        }
      },
    );
  }

  Widget _crearEdad(){
    return TextFormField(
      initialValue: alumno.edad.toString(),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        filled: true,
        icon: Icon(Icons.navigate_next),
        hintText: 'Edad',
        labelText: 'Edad *',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
      ),
      onSaved: (value) => alumno.edad = int.parse(value),
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

  Widget _crearEmail() {
    return TextFormField(
      initialValue: alumno.email,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        filled: true,
        icon: Icon(Icons.alternate_email),
        hintText: 'E-mail',
        labelText: 'E-mail *',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
      onSaved: (value) => alumno.email = value,
      validator: (value) {
        Pattern pattern =
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        RegExp regExp = new RegExp(pattern);

        if (regExp.hasMatch(value)) {
          return null;
        } else {
          return ('Ingrese un Email correcto');
        }
      },
    );
  }

  Widget _crearDisponible() {
    return SwitchListTile(
      value: alumno.estado,
      title: Text('Estado'),
      activeColor: Colors.blue,
      onChanged: (value) => setState(() {
        alumno.estado = value;

        if (value) {
          mostrarSnackbar("¡Usuario activo!");
        } else {
          mostrarSnackbar("¡Usuario inactivo!");
        }
      }),
    );
  }

  Widget _crearBotomRegistrar() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Colors.blue,
      textColor: Colors.white,
      label: Text('Guardar'),
      icon: Icon(Icons.save),
      onPressed: (_guardando) ? null : _submit,
    );
  }

  /* Widget _crearDropDownButtom(){
    final licenciaturasProvider = new LicenciaturasProvider();
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Icon(
          Icons.screen_share,
          size: 25.0,
        ),

        SizedBox(width: 100.0),
        
        FutureBuilder<List<LicenciaturaModel>>(
          future: licenciaturasProvider.cargarLicenciaturas(),

          builder: (BuildContext context, AsyncSnapshot<List<LicenciaturaModel>> snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();

            return DropdownButton<LicenciaturaModel>(
              
              items: snapshot.data.map((licenciatura) => DropdownMenuItem<LicenciaturaModel>(
                child: Text(licenciatura.nombre),
                value: licenciatura,
              )).toList(),
             
              onChanged: (LicenciaturaModel value) {
                setState(() {
                  _lic = alumno.licenciatura = value.nombre;
                  //print(_lic.nombre);
                  mostrarSnackbar("Licenciatura seleccionada: "+_lic);
                });
              },
              isExpanded: false,
              //value: _lic,
              hint: Text('Licenciatura'),
            );
          }),
      ],
    );
  }
  */

  Widget _crearDropDownButtomLista() {
    final licenciaturasProvider = new LicenciaturasProvider();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Icon(
          Icons.screen_share,
          size: 25.0,
        ),
        SizedBox(width: 50.0),
        FutureBuilder<List<LicenciaturaModel>>(
            future: licenciaturasProvider.cargarLicenciaturas(),
            builder: (BuildContext context,
                AsyncSnapshot<List<LicenciaturaModel>> snapshot) {
              if (!snapshot.hasData) return CircularProgressIndicator();

              return DropdownButton<String>(
                items: snapshot.data
                    .map((licenciatura) => DropdownMenuItem<String>(
                          child: Text(licenciatura.nombre),
                          value: licenciatura.nombre,
                        ))
                    .toList(),
                onChanged: (String value) {
                  setState(() {
                    _lic = alumno.licenciatura = value;
                    //print(_lic.nombre);
                    mostrarSnackbar(
                        "Licenciatura seleccionada: " + alumno.licenciatura);
                  });
                },
                value: _lic,
                hint: Text('Licenciatura'),
                isExpanded: false,
              );
            }),
      ],
    );
  }

  Widget _crearDropDownButtonSemestre(List<int> _semestre) {
    
    List<DropdownMenuItem<int>> lista = new List();
    _semestre.forEach((semes){
      lista.add( DropdownMenuItem(
        child: Text(semes.toString()),
        value: int.parse(semes.toString()),
      ));
    });   

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.confirmation_number,
          size: 25.0,
        ),
        SizedBox(width: 190.0),
        DropdownButton<int>(
          items: _semestre
              .map((value) => DropdownMenuItem(
                    child: Text(value.toString()),
                    value: value,
                  ))
              .toList(),
          onChanged: (selectedSemestre) {
            setState(() {
              seleccion = alumno.semestre = selectedSemestre;
              mostrarSnackbar("Semestre: " + seleccion.toString());
            });
          },
          value: seleccion,
          isExpanded: false,
          hint: Text('Semestre'),
        ),
      ],
    );
  }

  void _submit() async {
    if (!formKey.currentState.validate()) return;
    formKey.currentState.save();

    setState(() {
      _guardando = true;
    });

    if (_habilitar == true) {
      alumnosBloc.agregarAlumno(alumno);
      mostrarSnackbar('¡Alumno registrado exitosamente!');
    } else {
      alumnosBloc.editarAlumno(alumno);
      mostrarSnackbar('¡Alumno modificado exitosamente!');
    }
    
    Navigator.pop(context);
  }

  void mostrarSnackbar(String mensaje) {
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 1500),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
  }
}
