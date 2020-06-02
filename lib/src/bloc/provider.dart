import 'package:flutter/material.dart';
import 'package:practicum/src/bloc/actividades_bloc.dart';
import 'package:practicum/src/bloc/alumnos_bloc.dart';
import 'package:practicum/src/bloc/asesorados_bloc.dart';
import 'package:practicum/src/bloc/diagnostico_bloc.dart';
import 'package:practicum/src/bloc/diagnosticos_alumnos_bloc.dart';
import 'package:practicum/src/bloc/docentes_bloc.dart';
import 'package:practicum/src/bloc/evaluacion_clase_bloc.dart';
import 'package:practicum/src/bloc/inducciones_alumnos_bloc.dart';
import 'package:practicum/src/bloc/inducciones_bloc.dart';
import 'package:practicum/src/bloc/licenciaturas_bloc.dart';
export 'package:practicum/src/bloc/alumnos_bloc.dart';

import 'package:practicum/src/bloc/login_bloc.dart';
import 'package:practicum/src/bloc/plan_accion_tutorial_bloc.dart';
import 'package:practicum/src/bloc/plan_estudios_bloc.dart';
import 'package:practicum/src/bloc/principal_bloc.dart';
import 'package:practicum/src/bloc/sessiones_alumnos_bloc.dart';
import 'package:practicum/src/bloc/sessiones_bloc.dart';
import 'package:practicum/src/bloc/tutores_bloc.dart';
import 'package:practicum/src/bloc/user_groups_bloc.dart';
import 'package:practicum/src/bloc/users_bloc.dart';
export 'package:practicum/src/bloc/login_bloc.dart';

class Provider extends InheritedWidget{
  
  final loginBlock = new LoginBlock();
  final _alumnosBloc = new AlumnosBloc();
  final _licenciaturasBloc = new LicenciaturasBloc();
  final _docentesBloc = new DocentesBloc();
  final _tutoresBloc = new TutoresBloc();
  final _planEstudiosBloc = new PlanEstudiosBloc();
  final _userGroupsBloc = new UserGroupsBloc();
  final _usuariosBloc = new UsuariosBloc();
  final _induccionesBloc = new InduccionesBloc();
  final _asesoradosBloc = new AsesoradosBloc();
  final _planAcTutorialBloc = new PlanAccionTutorialBloc();
  final _sessioneslBloc = new SessionesBloc();
  final _diagnosticoBloc = new DiagnosticoBloc();
  final _evaluacionClaseBloc = new EvaluacionClaseBloc();
  final _principalBloc = new PrincipalBloc();
  final _actividadesBloc = new ActividadesBloc();
  final _sessionesAlumnosBloc = new SessionesAlumnosBloc();
  final _diagnosticosAlumnosBloc = DiagnosticoAlumnosBloc();
  final _induccionesAlumnosBloc = InduccionesAlumnosBloc();

  static Provider _instancia;

  factory Provider ({Key key, Widget child}){
    if(_instancia ==null){
      _instancia = new Provider._internal(key: key, child: child);
    }

    return _instancia;
  }

  Provider._internal({Key key, Widget child})
    : super(key: key, child: child);
    
  @override
  bool updateShouldNotify(InheritedWidget oldWidget)=>true;

  static LoginBlock of (BuildContext context){
    return (context.inheritFromWidgetOfExactType(Provider) as Provider).loginBlock;
  }

  static AlumnosBloc alumnosBloc (BuildContext context){
    return (context.inheritFromWidgetOfExactType(Provider) as Provider)._alumnosBloc;
  }

  static LicenciaturasBloc licenciaturasBloc (BuildContext context){
    return (context.inheritFromWidgetOfExactType(Provider) as Provider)._licenciaturasBloc;
  }

  static DocentesBloc docentesBloc (BuildContext context){
    return (context.inheritFromWidgetOfExactType(Provider) as Provider)._docentesBloc;
  }

  static TutoresBloc tutoresBloc (BuildContext context){
    return (context.inheritFromWidgetOfExactType(Provider) as Provider)._tutoresBloc;
  }

  static PlanEstudiosBloc planEstudiosBloc (BuildContext context){
    return (context.inheritFromWidgetOfExactType(Provider) as Provider)._planEstudiosBloc;
  }

  static UserGroupsBloc userGroupsBloc (BuildContext context){
    return (context.inheritFromWidgetOfExactType(Provider) as Provider)._userGroupsBloc;
  }

  static UsuariosBloc usuariosBloc (BuildContext context){
    return (context.inheritFromWidgetOfExactType(Provider) as Provider)._usuariosBloc;
  }

  static InduccionesBloc induccionesBloc (BuildContext context){
    return (context.inheritFromWidgetOfExactType(Provider) as Provider)._induccionesBloc;
  }

  static AsesoradosBloc asesoradosBloc (BuildContext context){
    return (context.inheritFromWidgetOfExactType(Provider) as Provider)._asesoradosBloc;
  }

  static PlanAccionTutorialBloc planAccionTutorial (BuildContext context){
    return (context.inheritFromWidgetOfExactType(Provider) as Provider)._planAcTutorialBloc;
  }

  static SessionesBloc sessionesBloc (BuildContext context){
    return (context.inheritFromWidgetOfExactType(Provider) as Provider)._sessioneslBloc;
  }
  
  static DiagnosticoBloc diagnosticoBloc (BuildContext context){
    return (context.inheritFromWidgetOfExactType(Provider) as Provider)._diagnosticoBloc;
  }
  
  static EvaluacionClaseBloc evaluacionClaseBloc (BuildContext context){
    return (context.inheritFromWidgetOfExactType(Provider) as Provider)._evaluacionClaseBloc;
  }

  static PrincipalBloc principalBloc (BuildContext context){
    return (context.inheritFromWidgetOfExactType(Provider) as Provider)._principalBloc;
  }

  static ActividadesBloc actividadesBloc (BuildContext context){
    return (context.inheritFromWidgetOfExactType(Provider) as Provider)._actividadesBloc;
  }

  static SessionesAlumnosBloc sessionesAlumnosBloc (BuildContext context){
    return (context.inheritFromWidgetOfExactType(Provider) as Provider)._sessionesAlumnosBloc;
  }

  static DiagnosticoAlumnosBloc diagnosticosAlumnosBloc (BuildContext context){
    return (context.inheritFromWidgetOfExactType(Provider) as Provider)._diagnosticosAlumnosBloc;
  }

  static InduccionesAlumnosBloc induccionesAlumnosBloc (BuildContext context){
    return (context.inheritFromWidgetOfExactType(Provider) as Provider)._induccionesAlumnosBloc;
  }
}