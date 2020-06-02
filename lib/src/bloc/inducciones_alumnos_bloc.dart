import 'package:practicum/src/models/inducciones_alumnos_models.dart';
import 'package:practicum/src/providers/inducciones_alumnos_provider.dart';
import 'package:rxdart/rxdart.dart';

class InduccionesAlumnosBloc{
  final _induccionesController = new BehaviorSubject<List<InduccionesAlumnosModels>>();
  final _cargandoController  = new BehaviorSubject<bool>();

  final __induccionesProvider   = new InduccionesAlumnosProvider();


  Stream<List<InduccionesAlumnosModels>> get induccionesStream => _induccionesController.stream;
  Stream<bool> get cargando => _cargandoController.stream;

  void cargarInduccionesAlumnos() async {

    final usuarios = await __induccionesProvider.cargarDatosInduccionesAlumnos();
    _induccionesController.sink.add( usuarios );
  }

  dispose() {
    _induccionesController?.close();
    _cargandoController?.close();
  }
}