import 'package:practicum/src/models/user_groups_models.dart';
import 'package:practicum/src/providers/users_grupos_provider.dart';
import 'package:rxdart/rxdart.dart';

class UserGroupsBloc{
  final _gruposController = new BehaviorSubject<List<GruposModel>>();
  final _cargandoController  = new BehaviorSubject<bool>();

  final __gruposProvider   = new GruposProvider();


  Stream<List<GruposModel>> get gruposStream => _gruposController.stream;
  Stream<bool> get cargando => _cargandoController.stream;

  void cargarGrupos() async {

    final grupos = await __gruposProvider.cargarGrupos();
    _gruposController.sink.add( grupos );
  }

  dispose() {
    _gruposController?.close();
    _cargandoController?.close();
  }
}