import 'package:practicum/src/models/actividades_models.dart';
import 'package:practicum/src/providers/plan_accion_tutorial_provider.dart';
import 'package:rxdart/rxdart.dart';

class ActividadesBloc{
  final _actividadesController = new BehaviorSubject<List<ActividadesModels>>();
  final _cargandoController  = new BehaviorSubject<bool>();

  final __planAccionTutorialProvider   = new PlanAccionTutorialProvider();


  Stream<List<ActividadesModels>> get actividadesStream => _actividadesController.stream;
  Stream<bool> get cargando => _cargandoController.stream;

  void cargarplanAccionTutorialAlumnos() async {

    final planAccionTutorial = await __planAccionTutorialProvider.cargarPlanAccionTutorialAlumno();
    _actividadesController.sink.add( planAccionTutorial );
  }

  dispose() {
    _actividadesController?.close();
    _cargandoController?.close();
  }
}