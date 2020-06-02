import 'package:practicum/src/models/diagnostico_models.dart';
import 'package:practicum/src/providers/diagnostico_provider.dart';
import 'package:rxdart/rxdart.dart';

class DiagnosticoBloc{
  final _diagnosticoController = new BehaviorSubject<List<DiagnosticoModel>>();
  final _cargandoController  = new BehaviorSubject<bool>();

  final __diagnosticoProvider   = new DiagnosticoProvider();


  Stream<List<DiagnosticoModel>> get diagnosticoStream => _diagnosticoController.stream;
  Stream<bool> get cargando => _cargandoController.stream;

  void cargarDiagnostico() async {

    final diagnostico = await __diagnosticoProvider.cargarDiagnostico();
    _diagnosticoController.sink.add( diagnostico );
  }

  void agregarDiagnostico( DiagnosticoModel docente ) async {

    _cargandoController.sink.add(true);
    await __diagnosticoProvider.crearDiagnostico(docente);
    _cargandoController.sink.add(false);

  }

  void borrarDiagnostico( String id ) async {
    await __diagnosticoProvider.borrarDiagnostico(id);  
  }
  
  void editarDiagnostico( DiagnosticoModel docente ) async {

    _cargandoController.sink.add(true);
    await __diagnosticoProvider.editarDiagnostico(docente);
    _cargandoController.sink.add(false);

  }

  dispose() {
    _diagnosticoController?.close();
    _cargandoController?.close();
  }
}