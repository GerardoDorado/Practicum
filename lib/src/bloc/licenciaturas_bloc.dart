
import 'package:practicum/src/models/licenciaturas_models.dart';
import 'package:practicum/src/providers/licenciaturas_provider.dart';
import 'package:rxdart/subjects.dart';

class LicenciaturasBloc{
  final _licecenciaturasController = new BehaviorSubject<List<LicenciaturaModel>>();
  final _cargandoController  = new BehaviorSubject<bool>();

  final __licenciaturasProvider   = new LicenciaturasProvider();


  Stream<List<LicenciaturaModel>> get licenciaturasStream => _licecenciaturasController.stream;
  Stream<bool> get cargando => _cargandoController.stream;

  void cargarLicenciaturas() async {

    final licenciaturas = await __licenciaturasProvider.cargarLicenciaturas();
    _licecenciaturasController.sink.add( licenciaturas );
  }

  void agregarLicenciatura( LicenciaturaModel licenciatura ) async {

    _cargandoController.sink.add(true);
    await __licenciaturasProvider.crearLicenciatura(licenciatura);
    _cargandoController.sink.add(false);

  }

  void borrarLicenciatura( String id ) async {
    await __licenciaturasProvider.borrarLicenciatura(id);  
  }
  
  void editarLicenciatura( LicenciaturaModel licenciatura ) async {

    _cargandoController.sink.add(true);
    await __licenciaturasProvider.editarLicenciatura(licenciatura);
    _cargandoController.sink.add(false);

  }

  dispose() {
    _licecenciaturasController?.close();
    _cargandoController?.close();
  }
}