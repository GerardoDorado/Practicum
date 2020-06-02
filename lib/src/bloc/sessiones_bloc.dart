import 'package:practicum/src/models/sessiones_models.dart';
import 'package:practicum/src/providers/sessiones_provider.dart';
import 'package:rxdart/rxdart.dart';

class SessionesBloc{
  final _sessionesController = new BehaviorSubject<List<SessionesModel>>();
  final _cargandoController  = new BehaviorSubject<bool>();

  final __sessionesProvider   = new SessionesProvider();


  Stream<List<SessionesModel>> get sessionesStream => _sessionesController.stream;
  Stream<bool> get cargando => _cargandoController.stream;

  void cargarSessiones() async {

    final sessiones = await __sessionesProvider.cargarSessiones();
    _sessionesController.sink.add( sessiones );
  }

  dispose() {
    _sessionesController?.close();
    _cargandoController?.close();
  }
}