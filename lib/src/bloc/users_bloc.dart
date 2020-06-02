import 'package:practicum/src/models/users_models.dart';
import 'package:practicum/src/providers/users_provider.dart';
import 'package:rxdart/rxdart.dart';

class UsuariosBloc{
  final _usuariosController = new BehaviorSubject<List<UsuariosModel>>();
  final _cargandoController  = new BehaviorSubject<bool>();

  final __usuariosProvider   = new UsersProvider();


  Stream<List<UsuariosModel>> get usuariosStream => _usuariosController.stream;
  Stream<bool> get cargando => _cargandoController.stream;

  void cargarUsuarios() async {

    final usuarios = await __usuariosProvider.cargarUsuarios();
    _usuariosController.sink.add( usuarios );
  }

  dispose() {
    _usuariosController?.close();
    _cargandoController?.close();
  }
}