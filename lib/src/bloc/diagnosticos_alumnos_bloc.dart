
import 'package:practicum/src/models/diagnosticos_alumnos_models.dart';
import 'package:practicum/src/providers/diagnostico_provider.dart';
import 'package:rxdart/rxdart.dart';

class DiagnosticoAlumnosBloc{
  final _diagnosticoController = new BehaviorSubject<List<DiagnosticosAlumnosModels>>();
  final _cargandoController  = new BehaviorSubject<bool>();

  final __diagnosticoProvider   = new DiagnosticoProvider();


  Stream<List<DiagnosticosAlumnosModels>> get diagnosticoStream => _diagnosticoController.stream;
  Stream<bool> get cargando => _cargandoController.stream;

  void cargarDiagnosticoAlumnos() async {

    final diagnostico = await __diagnosticoProvider.cargarDiagnosticoAlumnos();
    _diagnosticoController.sink.add( diagnostico );
  }

  dispose() {
    _diagnosticoController?.close();
    _cargandoController?.close();
  }
}