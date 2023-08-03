import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Periodo extends StatefulWidget {
  final int numeroParcela;

  Periodo({
    super.key,
    required this.numeroParcela,
  });

  @override
  State<Periodo> createState() => _PeriodoState();
}

class _PeriodoState extends State<Periodo> {
  //Armazenando a data inicial
  TextEditingController dataInicialController = TextEditingController();
  TextEditingController dataFinalController = TextEditingController();
  DateTime? _dataInicialSelecionada;
  DateTime? _dataFinalSelecionada;

  _showDatePickerInicial() {
    showDatePicker(
      context: context,
      initialDate: DateTime(2023),
      firstDate: DateTime(2023),
      lastDate: DateTime(2024),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      } else {
        setState(() {
          _dataInicialSelecionada = pickedDate;
        });
        dataInicialController.text =
            DateFormat('dd/MM/yyyy').format(_dataInicialSelecionada!);
        print(dataInicialController);
      }
    });
  }

  _showDatePickerFinal() {
    showDatePicker(
      context: context,
      initialDate: DateTime(2023),
      firstDate: DateTime(2023),
      lastDate: DateTime(2024),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      } else {
        setState(() {
          _dataFinalSelecionada = pickedDate;
        });
        dataInicialController.text =
            DateFormat('dd/MM/yyyy').format(_dataFinalSelecionada!);
        print(dataFinalController);
      }
    });
  }

  // DateTime? _dataSelecionada = DateTime.now();

  // DateTimeRange? intervaloSelecionado;
  // DateTimeRange? intervaloSelecionado;

  //método para armazenar data
  // Future<void> fetchData(BuildContext context) async {
  //   DateTimeRange? dataSelecionada = await showDateRangePicker(
  //     context: context,
  //     firstDate: DateTime(2024),
  //     lastDate: DateTime(2025),
  //   );

  //   if (dataSelecionada != null) {
  //     intervaloSelecionado = dataSelecionada;
  //     if (intervaloSelecionado != null) {
  //       dataInicialController.text =
  //           DateFormat('dd/MM/yyyy').format(intervaloSelecionado!.start);
  //       print(dataInicialController);

  //       dataFinalController.text =
  //           DateFormat('dd/MM/yyyy').format(intervaloSelecionado!.end);
  //       print(dataFinalController);
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    dataInicialController.text = _dataInicialSelecionada != null
        ? DateFormat('dd/MM/yyyy').format(_dataInicialSelecionada!)
        : '';
    dataFinalController.text = _dataFinalSelecionada != null
        ? DateFormat('dd/MM/yyyy').format(_dataFinalSelecionada!)
        : '';

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${widget.numeroParcela + 1}º Período',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
              margin: const EdgeInsets.only(left: 2),
              height: 16,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: const Color.fromARGB(255, 218, 44, 32),
              ),
              child: const Text(
                'Não solicitada',
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(left: 5.0, top: 1.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text('Data de início'),
                  IconButton(
                    onPressed: () {
                      print('calendar date picker');
                      _showDatePickerInicial();
                    },
                    icon: const Icon(
                      Icons.calendar_month_outlined,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 35),
                  const Text('Data Final'),
                  IconButton(
                    onPressed: () {
                      print('calendar date picker');
                      _showDatePickerFinal();
                    },
                    icon: const Icon(
                      Icons.calendar_month_outlined,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Form(
                    child: SizedBox(
                      width: 117,
                      height: 22,
                      child: TextFormField(
                        controller: dataInicialController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 50),
                  SizedBox(
                    width: 117,
                    height: 22,
                    child: TextFormField(
                      controller: dataFinalController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
