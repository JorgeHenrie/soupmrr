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

  DateTimeRange? intervaloSelecionado;

  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  void _submitForm() {
    _formKey.currentState?.save();
    print(_formData.values);
  }

  //método para armazenar data
  Future<void> fetchData(BuildContext context) async {
    DateTimeRange? dataSelecionada = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2024),
      lastDate: DateTime(2025),
    );

    if (dataSelecionada != null) {
      intervaloSelecionado = dataSelecionada;
      if (intervaloSelecionado != null) {
        dataInicialController.text =
            DateFormat('dd/MM/yyyy').format(intervaloSelecionado!.start);
        print(dataInicialController);

        dataFinalController.text =
            DateFormat('dd/MM/yyyy').format(intervaloSelecionado!.end);
        print(dataFinalController);
      }
    }
  }

  @override
  void dispose() {
    dataInicialController.dispose();
    dataFinalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    dataInicialController.text = '';
    dataFinalController.text = '';

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
                      fetchData(context);
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
                      fetchData(context);
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
                    key: _formKey,
                    child: SizedBox(
                      width: 117,
                      height: 22,
                      child: TextFormField(
                        controller: dataInicialController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        onFieldSubmitted: (_) => _submitForm(),
                        onSaved: (data) => _formData['dataInicio'] = data ?? '',
                        readOnly: false,
                        validator: (_data) {
                          final data = _data ?? '';
                          if (data.isEmpty) {
                            return 'Data é obrigatória';
                          }
                        },
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
                      onSaved: (dataFinal) =>
                          _formData['dataFinal'] = dataFinal ?? '',
                      readOnly: true,
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
