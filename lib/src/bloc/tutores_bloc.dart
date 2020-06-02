import 'package:practicum/src/models/tutores_models.dart';
import 'package:practicum/src/providers/tutores_provider.dart';
import 'package:rxdart/rxdart.dart';

class TutoresBloc{
  final _tutoresController = new BehaviorSubject<List<TutoresModel>>();
  final _cargandoController  = new BehaviorSubject<bool>();

  final __tutoresProvider   = new TutoresProvider();


  Stream<List<TutoresModel>> get tutoresStream => _tutoresController.stream;
  Stream<bool> get cargando => _cargandoController.stream;

  void cargarTutores() async {

    final tutores = await __tutoresProvider.cargarTutores();
    _tutoresController.sink.add( tutores );
  }

  dispose() {
    _tutoresController?.close();
    _cargandoController?.close();
  }
}