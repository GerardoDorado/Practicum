import 'package:flutter/material.dart';
import 'package:practicum/src/bloc/provider.dart';
import 'package:practicum/src/paginas/docentes.dart';
import 'package:practicum/src/paginas/Alumnos.dart';
import 'package:practicum/src/paginas/home_admin.dart';
import 'package:practicum/src/paginas/login.dart';
import 'package:practicum/src/preferencias_usuarios/preferencia_usuario.dart';
import 'package:practicum/src/views/altas_alumno.dart';
import 'package:practicum/src/views/altas_diagnostico.dart';
import 'package:practicum/src/views/altas_docente.dart';
import 'package:practicum/src/views/altas_licenciatura.dart';
import 'package:practicum/src/views/altas_tutores.dart';
import 'package:practicum/src/views/configuraciones.dart';
import 'package:practicum/src/views/consultas_actividades_alumnos.dart';
import 'package:practicum/src/views/consultas_alumnos.dart';
import 'package:practicum/src/views/consultas_asesorados.dart';
import 'package:practicum/src/views/consultas_diagnostico.dart';
import 'package:practicum/src/views/consultas_diagnosticos_alumnos.dart';
import 'package:practicum/src/views/consultas_docentes.dart';
import 'package:practicum/src/views/consultas_evaluacion_clase.dart';
import 'package:practicum/src/views/consultas_evaluacion_clase_alumno.dart';
import 'package:practicum/src/views/consultas_evaluacion_final_alumnos.dart';
import 'package:practicum/src/views/consultas_inducciones.dart';
import 'package:practicum/src/views/consultas_inducciones_alumnos.dart';
import 'package:practicum/src/views/consultas_licenciaturas.dart';
import 'package:practicum/src/views/consultas_plan_accion_tutorial.dart';
import 'package:practicum/src/views/consultas_plan_estudios.dart';
import 'package:practicum/src/views/consultas_reflexion_alumnos.dart';
import 'package:practicum/src/views/consultas_retroalimentacion_alumnos.dart';
import 'package:practicum/src/views/consultas_sessiones.dart';
import 'package:practicum/src/views/consultas_sessiones_alumnos.dart';
import 'package:practicum/src/views/consultas_tutorados.dart';
import 'package:practicum/src/views/consultas_tutores.dart';
import 'package:practicum/src/views/consultas_user_groups.dart';
import 'package:practicum/src/views/consultas_users.dart';
 
void main() async{
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  runApp(MyApp());
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Practicum',
        initialRoute: 'login',
        routes: {
          'login'                          : (BuildContext context) => Login(),
          'home_principal'                 : (BuildContext context) => PaginaPrincipal(),
          'alumnos'                        : (BuildContext context) => AltasAlumno(),
          'alumnosConsulta'                : (BuildContext context) => ConsultasAlumnos(),
          'licenciaturasConsulta'          : (BuildContext context) => ConsutasLicenciatura(),
          'licenciatura'                   : (BuildContext context) => AltasLicenciatura(),
          'docentesConsulta'               : (BuildContext context) => ConsultasDocentes(),
          'docentes'                       : (BuildContext context) => AltasDocente(),
          'docentes_principal'             : (BuildContext context) => DocentesPrincipal(),
          'alumnos_principal'              : (BuildContext context) => AlumnosPrincipal(),
          'configuraciones'                : (BuildContext context) => Configuraciones(),
          'tutoresConsulta'                : (BuildContext context) => ConsultasTutores(),
          'planEstudiosConsulta'           : (BuildContext context) => ConsultasPlanEstudios(),
          'userGroupsConsulta'             : (BuildContext context) => ConsultasUserGroups(),
          'usersConsulta'                  : (BuildContext context) => ConsultasUsuarios(),
          'induccionesConsulta'            : (BuildContext context) => ConsultasInducciones(),
          'asesoradosConsulta'             : (BuildContext context) => ConsultasAsesorados(),
          'planAccionTutorialConsulta'     : (BuildContext context) => ConsultasPlanAccionTutorial(),
          'sessionesConsulta'              : (BuildContext context) => ConsultasSessiones(),
          'diagnosticoConsulta'            : (BuildContext context) => ConsultasDiagnostico(),
          'evaluacionClaseConsulta'        : (BuildContext context) => ConsultasEvaluacionClase(),
          'altasTutores'                   : (BuildContext context) => AltasTutores(),
          'consultaTutorados'              : (BuildContext context) => ConsultaTutorados(),
          'actividadesConsulta'            : (BuildContext context) => ConsultasPlanAccionTutorialActividades(),
          'sessionesAlumnosConsulta'       : (BuildContext context) => ConsultasSessionesAlumnos(),
          'diagnosticoAlumnosConsulta'     : (BuildContext context) => ConsultasDiagnosticosAlumnos(),
          'evaluacionClaseAlumnoConsulta'  : (BuildContext context) => ConsultasEvaluacionClaseAlumno(),
          'retroalimentacionAlumnoConsulta': (BuildContext context) => ConsultasRetroalimentacionAlumno(),
          'reflexionAlumnoConsulta'        : (BuildContext context) => ConsultasReflexionAlumno(),
          'induccionesAlumnoConsulta'      : (BuildContext context) => ConsultasInduccionesAlumno(),
          'evaluacionFinalAlumnoConsulta'  : (BuildContext context) => ConsultasEvaluacionFinalAlumno(),
          'diagnosticos'                   : (BuildContext context) => AltasDiagnostico(),
        },  
      )
    );
  }
}