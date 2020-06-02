

import 'package:practicum/src/models/alumnos_models.dart';
import 'package:practicum/src/providers/alumnos_provider.dart';
import 'package:rxdart/rxdart.dart';

class AlumnosBloc {
  final _alumnosController = new BehaviorSubject<List<AlumnoModel>>();
  final _cargandoController  = new BehaviorSubject<bool>();

  final _alumnosProvider   = new AlumnosProvider();

  Stream<List<AlumnoModel>> get alumnosStream => _alumnosController.stream;
  Stream<bool> get cargando => _cargandoController.stream;

  void agregarAlumno( AlumnoModel alumno ) async {

    _cargandoController.sink.add(true);
    await _alumnosProvider.crearAlumno(alumno);
    _cargandoController.sink.add(false);

  }

  void cargarAlumnos() async {

    final alumnos = await _alumnosProvider.cargarALumnos();
    _alumnosController.sink.add( alumnos );
  }

  void borrarAlumno( String id ) async {
    await _alumnosProvider.borrarAlumno(id);  
  }
  
  void editarAlumno( AlumnoModel alumno ) async {

    _cargandoController.sink.add(true);
    await _alumnosProvider.editarAlumno(alumno);
    _cargandoController.sink.add(false);

  }

  dispose() {
    _alumnosController?.close();
    _cargandoController?.close();
  }

}