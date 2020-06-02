import 'package:practicum/src/models/evaluacion_clase_models.dart';
import 'package:practicum/src/providers/evaluacion_clase_provider.dart';
import 'package:rxdart/rxdart.dart';

class EvaluacionClaseBloc{
  final _evaluacionClaseController = new BehaviorSubject<List<EvaluacionClaseModel>>();
  final _cargandoController  = new BehaviorSubject<bool>();

  final __evaluacionClaseProvider   = new EvaluacionClaseProvider();


  Stream<List<EvaluacionClaseModel>> get evaluacionClaseStream => _evaluacionClaseController.stream;
  Stream<bool> get cargando => _cargandoController.stream;

  void cargarEvaluacionClase() async {

    final evaluacionClase = await __evaluacionClaseProvider.cargarEvaluacionClase();
    _evaluacionClaseController.sink.add( evaluacionClase );
  }

  void cargarEvaluacionClaseAlumno() async {

    final evaluacionClase = await __evaluacionClaseProvider.cargarEvaluacionClaseAlumno();
    _evaluacionClaseController.sink.add( evaluacionClase );
  }

  dispose() {
    _evaluacionClaseController?.close();
    _cargandoController?.close();
  }
}