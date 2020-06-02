import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:practicum/src/bloc/docentes_bloc.dart';
import 'package:practicum/src/bloc/provider.dart';
import 'package:practicum/src/models/docentes_models.dart';
import 'package:practicum/src/utils/utils.dart' as utils;
class AltasDocente extends StatefulWidget {

  static final String routeName = 'docentes';
  @override
  _AltasDocente createState() => _AltasDocente();
}

class _AltasDocente extends State<AltasDocente> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey     = GlobalKey<FormState>();
  
  DocentesBloc docentesBloc;
  DocenteModel docente = new DocenteModel();

  var seleccion;
  
  bool _guardando = false;
  bool _habilitar = true;
  
  @override
  Widget build(BuildContext context) {
    docentesBloc = Provider.docentesBloc(context);

    final DocenteModel docenteData = ModalRoute.of(context).settings.arguments;
    if ( docenteData != null ) {
      docente = docenteData;
      seleccion = docente.gradoAc;
      _habilitar = false;
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        //title: Text("Docentes"),
        title: Text("Profesores", style: TextStyle(color: Colors.blue)),
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
                _crearClaveD(),
                SizedBox(height: 24.0,),
                _crearNombre(),
                SizedBox(height: 24.0,),
                _crearApellidoPaterno(),
                SizedBox(height: 24.0,),
                _crearApellidoMaterno(),
                SizedBox(height: 24.0,),
                _crearEdad(),
                SizedBox(height: 24.0,),          
                _crearDropDownButtonGradoAcademico(),
                SizedBox(height: 24.0,),
                _crearEmail(),
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

  Widget _crearClaveD(){
    return TextFormField(
      initialValue: docente.claveD,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        filled: _habilitar,
        icon: Icon(Icons.navigate_next),
        hintText: 'Clave',
        labelText: 'Clave *',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
      ),
      enabled: _habilitar,
      onSaved: (value) => docente.claveD = value,
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
      initialValue: docente.nombre,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        filled: true,
        icon: Icon(Icons.person),
        hintText: 'Ingrese el nombre a registrar',
        labelText: 'Nombre *',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
      ),

      onSaved: (value) => docente.nombre = value,
      validator: (value) {
        if ( value.trimLeft().length < 3 || value.isEmpty ) {
          return 'Ingrese un nombre valido.';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearApellidoPaterno(){
    return TextFormField(
      initialValue: docente.primerAp,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        filled: true,
        icon: Icon(Icons.queue),
        hintText: 'Apellido paterno',
        labelText: 'Apellido paterno *',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
      ),

      onSaved: (value) => docente.primerAp = value,
      validator: (value) {
        if ( value.trimLeft().length < 3 || value.isEmpty ) {
          return 'Ingrese un apellido valido.';
        } else {
          return null;
        }
      },
    );
  } 

  Widget _crearApellidoMaterno(){
    return TextFormField(
      initialValue: docente.segundoAp,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        filled: true,
        icon: Icon(Icons.last_page),
        hintText: 'Apellido materno',
        labelText: 'Apellido materno *',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
      ),

      onSaved: (value) => docente.segundoAp = value,
      validator: (value) {
        if ( value.trimLeft().length < 3 || value.isEmpty ) {
          return 'Ingrese un apellido valido.';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearEmail(){
    return TextFormField(
      initialValue: docente.email,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        filled: true,
        icon: Icon(Icons.alternate_email),
        hintText: 'E-mail',
        labelText: 'E-mail *',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
      ),
      
      onSaved: (value) => docente.email = value,
      validator: (value) {
        Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        RegExp regExp   = new RegExp(pattern);

        if ( regExp.hasMatch( value ) ) {
          return null;
        } else {
          return('Ingrese un Email correcto');
        }
      },
    );
  }

  Widget _crearEdad(){
    return TextFormField(
      initialValue: docente.edad.toString(),
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
      onSaved: (value) => docente.edad = int.parse(value),
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

  Widget _crearDisponible() { 
    
    return SwitchListTile(
      value: docente.activo,
      title: Text('Estado'),
      activeColor: Colors.blue,
      onChanged: (value)=> setState((){
        docente.activo = value;  

        if (value) {
          mostrarSnackbar("¡Usuario activo!");
        }else{
          mostrarSnackbar("¡Usuario inactivo!");
        }    
      }),
    );
  }

  Widget _crearDropDownButtonGradoAcademico(){
    
    List<String> _gradoAc = <String>[
      "Maestria", "Doctorado", "Licenciatura"
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          Icons.library_books,
          size: 25.0,
        ),
        SizedBox(width: 140.0),
        DropdownButton(
          items: _gradoAc
            .map((value) => DropdownMenuItem(
                child: Text(value),
                value: value,
              ))
            .toList(),
          onChanged: (selectedGradoA) {
            setState(() {
              seleccion = docente.gradoAc = selectedGradoA;
              mostrarSnackbar("Semestre: "+seleccion);
            });
          },
          
          value: seleccion,
          isExpanded: false,
          hint: Text('Grado académico'),
        ),
      ],
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
      docentesBloc.agregarDocente(docente);
      mostrarSnackbar('¡Docente registrado exitosamente!');
    }else{
      docentesBloc.editarDocente(docente);
      mostrarSnackbar('¡Docente modificado exitosamente!');
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