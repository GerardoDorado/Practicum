// Adapted from the data table demo in offical flutter gallery:
// https://github.com/flutter/flutter/blob/master/examples/flutter_gallery/lib/demo/material/data_table_demo.dart
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practicum/src/models/alumnos_models.dart';
import 'package:practicum/src/preferencias_usuarios/preferencia_usuario.dart';
import 'package:practicum/src/widgets/menu_widget.dart';

import 'package:http/http.dart' as http;

class AltasTutores extends StatefulWidget {
  //const DataTableExample({Key key}) : super(key: key);
  static final String routeName = 'altasTutores';

  @override
  _PaginaAltasTutores createState() => _PaginaAltasTutores();
}

class _PaginaAltasTutores extends State<AltasTutores> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  List<AlumnoModel> _listaAlumnos = new List();
  
  final _prefs = new PreferenciasUsuario();
  
  int _sortColumnIndex;
  bool _sortAscending = true;

  void _sort<T>(Comparable<T> getField(AlumnoModel d), int columnIndex, bool ascending) {
    DatosTableAlumnos(_listaAlumnos)._sort<T>(getField, ascending);
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  cargarDatosPrincipal() async {
    final url = '${ _prefs.direccionHost }/practicum_php/consultaAlumnos.php';
    final resp = await http.get(
      Uri.encodeFull(url),
      headers: {"Accept": "application/json"},
    );

    if (resp.statusCode == 200) {
      final items = json.decode(resp.body).cast<Map<String, dynamic>>();
      List<AlumnoModel> listaAlumnos = items.map<AlumnoModel>((json) {
        return AlumnoModel.fromJson(json);
      }).toList();
      
      setState(() {
        _listaAlumnos = listaAlumnos;
        //_listaAlumnos = await usuarioProvider.cargarALumnos();    
      });
    } else {
      throw Exception('Failed to load internet');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Relación tutorial", style: TextStyle(color: Colors.blue)),
          iconTheme: new IconThemeData(color: Colors.blue),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        drawer: MenuWidget(),
        body: SingleChildScrollView(
          child: PaginatedDataTable(
            header: Text('Alumnos'),
            sortColumnIndex: _sortColumnIndex,
            sortAscending: _sortAscending,
            //onSelectAll: DatosTableAlumnos(_listaAlumnos)._selectAll,
            actions: <Widget>[
              IconButton(icon: Icon(Icons.add),onPressed: () => Navigator.pushNamed(context, 'alumnos'),),
              IconButton(icon: Icon(Icons.delete),onPressed: (){},),
            ],
            rowsPerPage: _rowsPerPage,
            availableRowsPerPage: [2, 3, 5, 10, 20],
            onRowsPerPageChanged: (int value) {
              setState(() {
                _rowsPerPage = value;
              });
            },

            columns: <DataColumn>[
              DataColumn(
                label: const Text('Matricula'),
                onSort: (int columnIndex, bool ascending) => _sort<num>((AlumnoModel d) => d.matricula, columnIndex, ascending), 
                numeric: true,
              ),
              DataColumn(
                label: const Text('Nombre'),
                tooltip: 'Nombre del alumno',
                onSort: (int columnIndex, bool ascending) => _sort<String>((AlumnoModel d) => d.nombre, columnIndex, ascending)
              ),
              DataColumn(
                label: const Text('Apellido Paterno'),
                onSort: (int columnIndex, bool ascending) => _sort<String>((AlumnoModel d) => d.primerAp, columnIndex, ascending)
              ),
              DataColumn(
                label: const Text('Apellido Materno'),
                onSort: (int columnIndex, bool ascending) => _sort<String>((AlumnoModel d) => d.segundoAp, columnIndex, ascending)
              ),
              DataColumn(
                label: const Text('Semestre'),
                onSort: (int columnIndex, bool ascending) => _sort<num>((AlumnoModel d) => d.semestre, columnIndex, ascending), 
                numeric: true,
              ),
              DataColumn(
                label: const Text('Edad'),
                onSort: (int columnIndex, bool ascending) => _sort<num>((AlumnoModel d) => d.edad, columnIndex, ascending), 
                numeric: true,
              ),
              DataColumn(
                label: const Text('Licenciatura'),
                onSort: (int columnIndex, bool ascending) => _sort<String>((AlumnoModel d) => d.licenciatura, columnIndex, ascending)
              ),
              DataColumn(
                label: const Text('Email'),
                onSort: (int columnIndex, bool ascending) => _sort<String>((AlumnoModel d) => d.email, columnIndex, ascending),
                tooltip:
                    'Email del alumno',
              ),
              DataColumn(
                label: const Text('Estado'),
                tooltip:
                    'Estado del alumno.',
              ),
            ],
            source: DatosTableAlumnos(_listaAlumnos),
          ),
        ));
  }

  @override
  void initState() {
    super.initState();
    cargarDatosPrincipal();
  }
}

class DatosTableAlumnos extends DataTableSource {
  DatosTableAlumnos(this._listaAlumnos);
  final List<AlumnoModel> _listaAlumnos;

  void _sort<T>(Comparable<T> getField(AlumnoModel d), bool ascending) {
    _listaAlumnos.sort((AlumnoModel a, AlumnoModel b) {
      if (!ascending) {
        final AlumnoModel c = a;
        a = b;
        b = c;
      }
      final Comparable<T> aValue = getField(a);
      final Comparable<T> bValue = getField(b);
      return Comparable.compare(aValue, bValue);
    });
    notifyListeners();
  }

  int _selectedCount = 0;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _listaAlumnos.length) return null;
    final AlumnoModel dessert = _listaAlumnos[index];
    return DataRow.byIndex(
        index: index,
        selected: dessert.selected,
        onSelectChanged: (bool value) {
          if (dessert.selected != value) {
            _selectedCount += value ? 1 : -1;
            assert(_selectedCount >= 0);
            dessert.selected = value;
            notifyListeners();
          }
        },
        cells: <DataCell>[
          DataCell(Text('${dessert.matricula}')),
          DataCell(Text('${dessert.nombre}')),
          DataCell(Text('${dessert.primerAp}')),
          DataCell(Text('${dessert.segundoAp}')),
          DataCell(Text('${dessert.semestre}')),
          DataCell(Text('${dessert.edad}')),
          DataCell(Text('${dessert.licenciatura}')),
          DataCell(Text('${dessert.email}')),
          DataCell(Text('${dessert.estado}')),
        ]);
  }

  @override
  int get rowCount => _listaAlumnos.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

}
