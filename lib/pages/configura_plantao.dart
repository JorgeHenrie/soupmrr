import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:rhmobile/models/plantao_model.dart';
import 'package:rhmobile/utils/app_routes.dart';

class ConfiguraPlantao extends StatefulWidget {
  const ConfiguraPlantao({Key? key}) : super(key: key);

  @override
  _ConfiguraPlantaoState createState() => _ConfiguraPlantaoState();
}

class _ConfiguraPlantaoState extends State<ConfiguraPlantao> {
  PlantaoModel plantao = PlantaoModel();
  String nomeCidade = "";
  final _cidades = [
    '12h/24h - 12h/72h',
    '24h/96h',
    '24h/72h',
    '8h/8h/8h - 72h'
  ];
  final _turno = [
    '1º Turno',
    '2º Turno',
  ];

  String? _itemSelecionado;
  bool escalaSelecionada = false;
  bool possuiTurno = false;
  TipoEscala? tipoEscala;
  DateTime dateSelected = DateTime.now().toUtc();
  String? _turnoSelecionado;

  @override
  Widget build(BuildContext context) {
    double hieght = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de serviço'),
      ),
      body: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: hieght * 0.03),
            const Text(
              'Selecione o seu tipo de escala: ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: hieght * 0.02),
            DropdownButton<String>(
                hint: const Text("Selecione"),
                style: const TextStyle(color: Colors.blue),
                alignment: AlignmentDirectional.center,
                items: _cidades.map((String dropDownStringItem) {
                  return DropdownMenuItem<String>(
                    value: dropDownStringItem,
                    child: Text(dropDownStringItem),
                  );
                }).toList(),
                onChanged: ((novoItemSelecionado) {
                  _dropDownItemSelected(novoItemSelecionado!);
                  escalaSelecionada = true;
                  escolheTipo(novoItemSelecionado);
                  setState(() {
                    _itemSelecionado = novoItemSelecionado;
                  });
                }),
                value: _itemSelecionado),
            SizedBox(height: hieght * 0.03),
            escalaSelecionada == true
                ? Column(
                    children: [
                      const Text(
                        'Selecione o primeiro dia do serviço: ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(height: hieght * 0.02),
                      Container(
                        height: hieght * 0.10,
                        width: width * 0.40,
                        color: Color.fromARGB(255, 255, 255, 255),
                        child: Column(
                          children: [
                            SizedBox(
                              height: hieght * 0.10,
                              width: width * 0.40,
                              child: CupertinoTheme(
                                data: const CupertinoThemeData(
                                  textTheme: CupertinoTextThemeData(
                                    dateTimePickerTextStyle:
                                        TextStyle(fontSize: 16),
                                  ),
                                ),
                                child: CupertinoDatePicker(
                                    dateOrder: DatePickerDateOrder.dmy,
                                    mode: CupertinoDatePickerMode.date,
                                    initialDateTime: DateTime.now(),
                                    onDateTimeChanged: (val) {
                                      setState(() {
                                        dateSelected = val.toUtc();
                                      });
                                    }),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                : Text(''),
            SizedBox(height: hieght * 0.04),
            possuiTurno == true
                ? Container(
                    // color: Colors.red,
                    width: width * 0.40,
                    height: hieght * 0.40,
                    child: Column(
                      children: [
                        const Text(
                          'Selecione o turno do primeiro serviço: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        SizedBox(height: hieght * 0.02),
                        DropdownButton<String>(
                            hint: const Text("Selecione o turno"),
                            style: const TextStyle(color: Colors.blue),
                            alignment: AlignmentDirectional.center,
                            items: _turno.map((String dropDownStringItem) {
                              return DropdownMenuItem<String>(
                                value: dropDownStringItem,
                                child: Text(dropDownStringItem),
                              );
                            }).toList(),
                            onChanged: ((novoTurnoSelecionado) {
                              _dropDownTurnoSelected(novoTurnoSelecionado!);

                              setState(() {
                                _turnoSelecionado = novoTurnoSelecionado;
                              });
                            }),
                            value: _turnoSelecionado),
                      ],
                    ),
                  )
                : Text(''),
            escalaSelecionada == true && possuiTurno == false ||
                    escalaSelecionada == true &&
                        possuiTurno == true &&
                        _turnoSelecionado != null
                ? ElevatedButton(
                    onPressed: () async {
                      await _salvaPlantao();
                    },
                    child: Text('Salvar Escala'))
                : Text(''),
          ],
        ),
      ),
    );
  }

  _salvaPlantao() async {
    Turno t = Turno.diario;
    if (tipoEscala == TipoEscala.ruaPadrao) {
      if (_turnoSelecionado == '1º Turno') {
        t = Turno.diurno;
      } else {
        t = Turno.noturno;
      }
    } else if (tipoEscala == TipoEscala.guarda) {
      t = Turno.diario;
    } else if (tipoEscala == TipoEscala.giro) {
      t = Turno.giro;
    }

    await plantao.salvaEscalaMemoria(dateSelected, tipoEscala!, t);
    Navigator.of(context).pushReplacementNamed(AppRoutes.PLANTAO);
  }

  void _dropDownItemSelected(String novoItem) {
    setState(() {
      _itemSelecionado = novoItem;
    });
  }

  void _dropDownTurnoSelected(String novoItem) {
    setState(() {
      _turnoSelecionado = novoItem;
    });
  }

  void escolheTipo(String tipo) {
    possuiTurno = false;
    if (tipo == '12h/24h - 12h/72h') {
      possuiTurno = true;
      tipoEscala = TipoEscala.ruaPadrao;
    } else if (tipo == '24h/96h') {
      tipoEscala = TipoEscala.guarda;
    } else if (tipo == '24h/72h') {
      tipoEscala = TipoEscala.guardaMenor;
    } else if (tipo == '8h/8h/8h - 72h') {
      tipoEscala = TipoEscala.giro;
    }
  }
}
