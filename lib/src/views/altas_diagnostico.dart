import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:practicum/src/bloc/diagnostico_bloc.dart';
import 'package:practicum/src/bloc/provider.dart';
import 'package:practicum/src/models/asesorados_models.dart';
import 'package:practicum/src/models/diagnostico_models.dart';
import 'package:practicum/src/providers/asesorados_providers.dart';

import 'package:practicum/src/utils/utils.dart' as utils;

class AltasDiagnostico extends StatefulWidget {
  static final String routeName = 'diagnosticos';
  @override
  _PaginaDiagnostico createState() => _PaginaDiagnostico();
}

class _PaginaDiagnostico extends State<AltasDiagnostico> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  DiagnosticoBloc diagnosticoBloc;
  DiagnosticoModel diagnostico = new DiagnosticoModel();

  //var _dig;
  var seleccion;

  bool _guardando = false;
  bool _habilitar = true;

  @override
  Widget build(BuildContext context) {
    diagnosticoBloc = Provider.diagnosticoBloc(context);
    final DiagnosticoModel digData = ModalRoute.of(context).settings.arguments;

    if (digData != null) {
      diagnostico = digData;
      //  _dig=diagnostico.claveD;
      seleccion = diagnostico.matricula;
      _habilitar = false;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title:
            Text("Agregar diagnóstico", style: TextStyle(color: Colors.blue)),
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
                _crearId(),
                SizedBox(
                  height: 24.0,
                ),
                _crearFortalezas(),
                SizedBox(
                  height: 24.0,
                ),
                _crearDebilidad(),
                SizedBox(
                  height: 24.0,
                ),
                _crearAspectos(),
                SizedBox(
                  height: 24.0,
                ),
                _crearEstrategias(),
                SizedBox(
                  height: 24.0,
                ),
                _crearDisponible(),
                SizedBox(
                  height: 24.0,
                ),
                _crearDropDownButtomLista(),
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

  Widget _crearId() {
    return TextFormField(
      initialValue: diagnostico.id.toString(),
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        filled: _habilitar,
        icon: Icon(Icons.navigate_next),
        hintText: 'id',
        labelText: 'id *',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
      enabled: _habilitar,
      onSaved: (value) => diagnostico.id = int.parse(value),
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

  Widget _crearFortalezas() {
    return TextFormField(
      initialValue: diagnostico.fortaleza,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        filled: true,
        icon: Icon(Icons.book),
        hintText: 'Ingrese la fortaleza a registrar',
        labelText: 'Fortaleza *',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
      onSaved: (value) => diagnostico.fortaleza = value,
      validator: (value) {
        if (value.trimRight().length < 3 || value.isEmpty) {
          return 'Ingrese un nombre valido.';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearDebilidad() {
    return TextFormField(
      initialValue: diagnostico.debilidad,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        filled: true,
        icon: Icon(Icons.book),
        hintText: 'Debilidadr',
        labelText: 'Debilidad *',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
      onSaved: (value) => diagnostico.debilidad = value,
      validator: (value) {
        if (value.trimLeft().length < 3 || value.isEmpty) {
          return 'Ingrese una debilidad valida.';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearAspectos() {
    return TextFormField(
      initialValue: diagnostico.aspecto,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        filled: true,
        icon: Icon(Icons.book),
        hintText: 'Aspecto',
        labelText: 'Aspecto *',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
      onSaved: (value) => diagnostico.aspecto = value,
      validator: (value) {
        if (value.trimLeft().length < 3 || value.isEmpty) {
          return 'Ingrese un aspecto.';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearEstrategias() {
    return TextFormField(
      initialValue: diagnostico.estrategia,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        filled: true,
        icon: Icon(Icons.book),
        hintText: 'Estrategias',
        labelText: 'Estrategias *',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
      onSaved: (value) => diagnostico.estrategia = value,
      validator: (value) {
        if (value.trimLeft().length < 3 || value.isEmpty) {
          return 'Ingrese una debilidad valida.';
        } else {
          return null;
        }
      },
    );
  }

  _crearDisponible() {
    return SwitchListTile(
      value: diagnostico.estadoFinal,
      title: Text('Estado'),
      activeColor: Colors.blue,
      onChanged: (value) => setState(() {
        diagnostico.estadoFinal = value;

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

  Widget _crearDropDownButtomLista() {
    final asesoradosProvider = new AsesoradosProvider();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Icon(
          Icons.confirmation_number,
          size: 25.0,
        ),
        SizedBox(width: 50.0),
        FutureBuilder<List<AsesoradosModel>>(
            future: asesoradosProvider.cargarAsesorados(),
            builder: (BuildContext context,
                AsyncSnapshot<List<AsesoradosModel>> snapshot) {
              if (!snapshot.hasData) return CircularProgressIndicator();

              return DropdownButton<int>(
                items: snapshot.data
                    .map((licenciatura) => DropdownMenuItem<int>(
                          child: Text(
                              '${licenciatura.matricula} - ${licenciatura.nombre}'),
                          value: licenciatura.matricula,
                        ))
                    .toList(),
                onChanged: (selectedMatricula) {
                  setState(() {
                    seleccion = diagnostico.matricula = selectedMatricula;
                    mostrarSnackbar("matricula: " + seleccion.toString());
                  });
                },
                value: seleccion,
                isExpanded: false,
                hint: Text('matricula'),
              );
            }),
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
      diagnosticoBloc.agregarDiagnostico(diagnostico);
      mostrarSnackbar('¡Diagnostico registrado exitosamente!');
    } else {
      diagnosticoBloc.editarDiagnostico(diagnostico);
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
