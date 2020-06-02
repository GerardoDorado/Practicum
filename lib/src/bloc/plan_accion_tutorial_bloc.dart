
import 'package:practicum/src/models/plan_accion_tutorial_models.dart';
import 'package:practicum/src/providers/plan_accion_tutorial_provider.dart';
import 'package:rxdart/rxdart.dart';

class PlanAccionTutorialBloc{
  final _planAccionTutorialController = new BehaviorSubject<List<PlanAccionTutorialModel>>();
  final _cargandoController  = new BehaviorSubject<bool>();

  final __planAccionTutorialProvider   = new PlanAccionTutorialProvider();


  Stream<List<PlanAccionTutorialModel>> get planAccionTutorialStream => _planAccionTutorialController.stream;
  Stream<bool> get cargando => _cargandoController.stream;

  void cargarplanAccionTutorial() async {

    final planAccionTutorial = await __planAccionTutorialProvider.cargarPlanAccionTutorial();
    _planAccionTutorialController.sink.add( planAccionTutorial );
  }

  dispose() {
    _planAccionTutorialController?.close();
    _cargandoController?.close();
  }
}