import 'package:practicum/src/models/plan_estudios.dart';
import 'package:practicum/src/providers/plan_estudios_provider.dart';
import 'package:rxdart/rxdart.dart';

class PlanEstudiosBloc{
  final _planEstudiosController = new BehaviorSubject<List<PlanEstudiosModel>>();
  final _cargandoController  = new BehaviorSubject<bool>();

  final __planEstudiosProvider   = new PlanEstudiosProvider();


  Stream<List<PlanEstudiosModel>> get planEstudiosStream => _planEstudiosController.stream;
  Stream<bool> get cargando => _cargandoController.stream;

  void cargarPlanEstudios() async {

    final planEstudios = await __planEstudiosProvider.cargarPlanEstudios();
    _planEstudiosController.sink.add( planEstudios );
  }

  dispose() {
    _planEstudiosController?.close();
    _cargandoController?.close();
  }
}