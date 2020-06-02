import 'package:practicum/src/models/sessiones_alumnos_models.dart';
import 'package:practicum/src/providers/sessiones_provider.dart';
import 'package:rxdart/rxdart.dart';

class SessionesAlumnosBloc{
  final _sessionesController = new BehaviorSubject<List<SessionesAlumnosModels>>();
  final _cargandoController  = new BehaviorSubject<bool>();

  final __sessionesProvider   = new SessionesProvider();


  Stream<List<SessionesAlumnosModels>> get sessionesStream => _sessionesController.stream;
  Stream<bool> get cargando => _cargandoController.stream;

  void cargarSessionesAlumnos() async {

    final sessiones = await __sessionesProvider.cargarSessionesAlumnos();
    _sessionesController.sink.add( sessiones );
  }

  dispose() {
    _sessionesController?.close();
    _cargandoController?.close();
  }
}