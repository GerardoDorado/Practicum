import 'package:practicum/src/models/inducciones_models.dart';
import 'package:practicum/src/providers/inducciones_provider.dart';
import 'package:rxdart/rxdart.dart';

class InduccionesBloc{
  final _induccionesController = new BehaviorSubject<List<InduccionesModel>>();
  final _cargandoController  = new BehaviorSubject<bool>();

  final __induccionesProvider   = new InduccionesProvider();


  Stream<List<InduccionesModel>> get induccionesStream => _induccionesController.stream;
  Stream<bool> get cargando => _cargandoController.stream;

  void cargarInducciones() async {

    final usuarios = await __induccionesProvider.cargarDatosInducciones();
    _induccionesController.sink.add( usuarios );
  }

  dispose() {
    _induccionesController?.close();
    _cargandoController?.close();
  }
}