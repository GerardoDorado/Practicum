import 'package:practicum/src/models/asesorados_models.dart';
import 'package:practicum/src/providers/asesorados_providers.dart';
import 'package:rxdart/rxdart.dart';

class AsesoradosBloc{
  final _asesoradosController = new BehaviorSubject<List<AsesoradosModel>>();
  final _cargandoController  = new BehaviorSubject<bool>();

  final __asesoradosProvider   = new AsesoradosProvider();


  Stream<List<AsesoradosModel>> get asesoradosStream => _asesoradosController.stream;
  Stream<bool> get cargando => _cargandoController.stream;

  void cargarAsesorados() async {

    final asesorados = await __asesoradosProvider.cargarAsesorados();
    _asesoradosController.sink.add( asesorados );
  }

  dispose() {
    _asesoradosController?.close();
    _cargandoController?.close();
  }
}