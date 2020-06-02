import 'package:practicum/src/models/docentes_models.dart';
import 'package:practicum/src/providers/docentes_provider.dart';
import 'package:rxdart/subjects.dart';

class DocentesBloc{
  final _docentesController = new BehaviorSubject<List<DocenteModel>>();
  final _cargandoController  = new BehaviorSubject<bool>();

  final __docentesProvider   = new DocentesProvider();


  Stream<List<DocenteModel>> get docentesStream => _docentesController.stream;
  Stream<bool> get cargando => _cargandoController.stream;

  void cargarDocentes() async {

    final docentes = await __docentesProvider.cargarDocentes();
    _docentesController.sink.add( docentes );
  }

  void agregarDocente( DocenteModel docente ) async {

    _cargandoController.sink.add(true);
    await __docentesProvider.crearDocente(docente);
    _cargandoController.sink.add(false);

  }

  void borrarDocente( String id ) async {
    await __docentesProvider.borrarDocente(id);  
  }
  
  void editarDocente( DocenteModel docente ) async {

    _cargandoController.sink.add(true);
    await __docentesProvider.editarDocente(docente);
    _cargandoController.sink.add(false);

  }

  dispose() {
    _docentesController?.close();
    _cargandoController?.close();
  }
}