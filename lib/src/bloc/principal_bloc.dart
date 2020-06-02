import 'package:practicum/src/models/principal_models.dart';
import 'package:practicum/src/providers/principal_provider.dart';
import 'package:rxdart/rxdart.dart';

class PrincipalBloc{
  final _principalController = new BehaviorSubject<List<PrincipalModels>>();
  final _cargandoController  = new BehaviorSubject<bool>();

  final __principalProvider   = new PrincipalProvider();


  Stream<List<PrincipalModels>> get principalStream => _principalController.stream;
  Stream<bool> get cargando => _cargandoController.stream;

  void cargarPrincipal() async {

    final principal = await __principalProvider.cargarPrincipal();
    _principalController.sink.add( principal );
  }

  dispose() {
    _principalController?.close();
    _cargandoController?.close();
  }
}