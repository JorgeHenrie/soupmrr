import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/quickalert.dart';
import 'package:rhmobile/models/efetivacao.dart';
import 'package:rhmobile/pages/page_ferias_periodo.dart';
import 'package:rhmobile/utils/app_routes.dart';

class ProgramarFerias extends StatefulWidget {
  const ProgramarFerias({super.key});

  @override
  State<ProgramarFerias> createState() => _ProgramarFeriasState();
}

class _ProgramarFeriasState extends State<ProgramarFerias> {
  //lista com dados simulados
  List<Efetivacao> efetivacao = [];
  late DateTime selectedDay;
  //variável para pegar o ano atual de forma dinâmica
  late int anoAtual;

  _ProgramarFeriasState() {
    //selectedval está sendo inicializada com o primeiro valor de _parcelas(integral)
    _selectedVal = _parcelas[0];
    _updateNumeroParcela();
  }

  //opções para o tipo de concessão de férias.
  final _parcelas = ["Intergral", "2º Período", "3º Período"];
  String? _selectedVal = "";
  int numeroParcela = 1;

  //método para atualizar o númeroParcela.
  void _updateNumeroParcela() {
    switch (_selectedVal) {
      case "2º Período":
        numeroParcela = 2;
        break;
      case "3º Período":
        numeroParcela = 3;
        break;
      default:
        numeroParcela = 1;
        break;
    }
  }

  //mensagem de sucesso personalizada
  Future<void> _showSucessAlert() async {
    await Future.delayed(Duration.zero);

    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      text: 'Férias solicitadas com sucesso!',
      confirmBtnText: 'Ok',
      onConfirmBtnTap: () {
        Navigator.of(context).pushNamedAndRemoveUntil(
          AppRoutes.FERIASHOME,
          (route) => false,
        );
        //Navigator.canPop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    //pegando o ano atual de forma dinâmica
    anoAtual = DateTime.now().year;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Férias'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 75,
                  width: 300,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 240, 240, 240),
                      borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Exercício ${anoAtual + 1}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '${DateFormat('dd/MM/yyyy').format(DateTime(anoAtual + 1, 1, 1))} a ${DateFormat('dd/MM/yyyy').format(DateTime(anoAtual + 1, 12, 31))}',
                      ),
                      const Text('30 dias'),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(10),
              height: 120,
              width: 370,
              decoration: BoxDecoration(
                border: Border.all(),
                color: const Color.fromARGB(255, 240, 240, 240),
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.assignment_late_outlined, color: Colors.blue),
                  Text(
                    'De acordo com a portaria nº 432/2018, art. 4º, o policial militar somente poderá entrar em gozo de férias, integral ou parcelada, após as mesmas serem publicadas em boletim geral.',
                    textAlign: TextAlign.justify,
                    maxLines: 4,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField(
              //especifica o valor selecionado no menu
              value: _selectedVal,
              //exibe os elementos do array
              items: _parcelas
                  .map((e) => DropdownMenuItem(
                        child: Text(e),
                        value: e,
                      ))
                  .toList(),
              //chamada quando o valor do menu for alterado
              onChanged: (val) {
                setState(() {
                  _selectedVal = val;
                  _updateNumeroParcela();
                });
              },
              icon: const Icon(
                Icons.arrow_drop_down_circle,
                color: Colors.blue,
              ),
              dropdownColor: const Color.fromARGB(255, 214, 237, 255),
              decoration: const InputDecoration(
                labelText: "Efetivação",
                prefixIcon: Icon(
                  Icons.surfing,
                  color: Colors.blue,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: ListView.builder(
                itemCount: numeroParcela,
                itemExtent: 140,
                itemBuilder: ((context, index) {
                  return Container(
                    margin: const EdgeInsets.only(
                        bottom: 10), // Espaçamento entre os cartões
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 240, 240, 240),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Periodo(
                        numeroParcela: index,
                      ),
                    ),
                  );
                }),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Deseja solicitar suas férias?'),
                    content: const Text(
                        'Sujeito a confirmação da sua chefia imediata.'),
                    actions: [
                      TextButton(
                          onPressed: () {
                            _showSucessAlert();
                          },
                          child: Text(
                            'Sim',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.green,
                          )),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Não',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.red,
                          )),
                    ],
                  ),
                );
              },
              child: const Text('Solicitar férias'),
            ),
          ],
        ),
      ),
    );
  }
}
