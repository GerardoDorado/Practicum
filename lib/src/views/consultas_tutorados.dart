import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practicum/src/models/turados_models.dart';
import 'package:practicum/src/preferencias_usuarios/preferencia_usuario.dart';
import 'package:practicum/src/widgets/menu_widget.dart';

import 'package:http/http.dart' as http;

class ConsultaTutorados extends StatefulWidget {
  //const DataTableExample({Key key}) : super(key: key);
  static final String routeName = 'consultaTutorados';
  
  @override
  _PaginaConsultaTutorados createState() => _PaginaConsultaTutorados();
}

class _PaginaConsultaTutorados extends State<ConsultaTutorados> {
  final _prefs = new PreferenciasUsuario();
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex;

  List<TutoradosModels> _listaAlumnos = new List();
  //final String claveD = ModalRoute.of(context).settings.arguments;
  String claveD = "";
  bool _sortAscending = true;

  void _sort<T>(Comparable<T> getField(TutoradosModels d), int columnIndex, bool ascending) {
    DatosTableAlumnos(_listaAlumnos)._sort<T>(getField, ascending);
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  cargarDatosPrincipal(String _claveD) async {
    print(_claveD);
    final authData = {'claveD': _claveD};
    final url = '${ _prefs.direccionHost }/practicum_php/consultaTutorados.php';
    final resp = await http.post(
      Uri.encodeFull(url),
      headers: {"Accept": "application/json"},
      body: json.encode(authData)
    );

    if (resp.statusCode == 200) {
      final items = json.decode(resp.body).cast<Map<String, dynamic>>();
      List<TutoradosModels> listaAlumnos = items.map<TutoradosModels>((json) {
        return TutoradosModels.fromJson(json);
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
    //claveD = ModalRoute.of(context).settings.arguments;
    //print(claveD);
    print(_rowsPerPage); 
    print(_listaAlumnos.length);
    return Scaffold(
        appBar: AppBar(
          title: Text("Tutorados", style: TextStyle(color: Colors.blue)),
          iconTheme: new IconThemeData(color: Colors.blue),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        drawer: MenuWidget(),
        body: SingleChildScrollView(
          child: PaginatedDataTable(
            header: Text('Tutorados'),
            sortColumnIndex: _sortColumnIndex,
            sortAscending: _sortAscending,
            //onSelectAll: DatosTableAlumnos(_listaAlumnos)._selectAll,
            actions: <Widget>[
              //IconButton(icon: Icon(Icons.add),onPressed: () => Navigator.pushNamed(context, 'alumnos'),),
              IconButton(icon: Icon(Icons.delete),onPressed: (){},),
            ],
            rowsPerPage: _rowsPerPage,
            availableRowsPerPage: [1, 2, 3, 4, 5, 10, 20],
            onRowsPerPageChanged: (int value) {
              setState(() {
                _rowsPerPage = value;
              });
            },

            columns: <DataColumn>[
              DataColumn(
                label: const Text('Matricula'),
                onSort: (int columnIndex, bool ascending) => _sort<String>((TutoradosModels d) => d.matricula, columnIndex, ascending), 
                numeric: true,
              ),
              DataColumn(
                label: const Text('Nombre'),
                tooltip: 'Nombre del alumno',
                onSort: (int columnIndex, bool ascending) => _sort<String>((TutoradosModels d) => d.nombre, columnIndex, ascending)
              ),
              DataColumn(
                label: const Text('Apellido Paterno'),
                onSort: (int columnIndex, bool ascending) => _sort<String>((TutoradosModels d) => d.primerAp, columnIndex, ascending)
              ),
              DataColumn(
                label: const Text('Apellido Materno'),
                onSort: (int columnIndex, bool ascending) => _sort<String>((TutoradosModels d) => d.segundoAp, columnIndex, ascending)
              ),
              DataColumn(
                label: const Text('Semestre'),
                onSort: (int columnIndex, bool ascending) => _sort<num>((TutoradosModels d) => d.semestre, columnIndex, ascending), 
                numeric: true,
              ),
              DataColumn(
                label: const Text('Email'),
                onSort: (int columnIndex, bool ascending) => _sort<String>((TutoradosModels d) => d.email, columnIndex, ascending),
                tooltip:
                    'Email del alumno',
              ),
              
            ],
            source: DatosTableAlumnos(_listaAlumnos),
          ),
        ));
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        claveD = ModalRoute.of(context).settings.arguments as String;  
      });
      cargarDatosPrincipal(claveD);
    });
    //cargarDatosPrincipal(claveD); 
  }
}

class DatosTableAlumnos extends DataTableSource {
  DatosTableAlumnos(this._listaAlumnos);
  final List<TutoradosModels> _listaAlumnos;

  void _sort<T>(Comparable<T> getField(TutoradosModels d), bool ascending) {
    _listaAlumnos.sort((TutoradosModels a, TutoradosModels b) {
      if (!ascending) {
        final TutoradosModels c = a;
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
    final TutoradosModels dessert = _listaAlumnos[index];
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
          DataCell(Text('${dessert.email}')),
        ]);
  }

  @override
  int get rowCount => _listaAlumnos.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

}
