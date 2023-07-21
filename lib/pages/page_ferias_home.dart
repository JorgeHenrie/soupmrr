import 'package:flutter/material.dart';
import 'package:rhmobile/utils/app_routes.dart';
import 'package:rhmobile/widgets/drawer_personalizado.dart';

class feriasHome extends StatefulWidget {
  const feriasHome({super.key});

  @override
  State<feriasHome> createState() => _feriasHomeState();
}

class _feriasHomeState extends State<feriasHome> {
  //List<Efetivacao> efetivacao = [];

  String valorEscolhido = "Integral";
  List<String> listItem = ["Integral", "Parcelado"];

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   //valorEscolhido = listItem[0];
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Férias'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
              height: 100,
              width: 370,
              color: const Color.fromARGB(123, 186, 196, 207),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Departamento - Seção',
                              // efetivacao[0].policialMilitar.departamento.nome,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 1),
                            Row(
                              children: [
                                Text(''),
                                SizedBox(width: 6),
                                Text(''),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Posto - Graduação',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(''),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 156,
              width: 370,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 4,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
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
                          const Row(
                            children: [
                              Text(
                                '2024',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    TextButton.icon(
                      onPressed: () {
                        print('cliquei');
                        Navigator.of(context)
                            .pushNamed(AppRoutes.PROGRAMAR_FERIAS);
                      },
                      icon: const Icon(Icons.calendar_month_outlined),
                      label: const Text('Programar Férias'),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('13º salário: '),
                        const SizedBox(width: 2),
                        DropdownButton(
                          value: valorEscolhido,
                          onChanged: (newValue) {
                            setState(() {
                              valorEscolhido = newValue as String;
                              print(valorEscolhido);
                            });
                          },
                          items: listItem.map((valueItem) {
                            return DropdownMenuItem(
                              value: valueItem,
                              child: Center(
                                child: Text(
                                  valueItem,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: Drawerpersonalizado(),
    );
  }
}
