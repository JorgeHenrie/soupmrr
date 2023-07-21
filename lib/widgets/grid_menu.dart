import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/auth_model.dart';
import '../utils/app_routes.dart';

class Choice {
  final String title;
  final IconData icon;
  final int id;
  Choice({required this.title, required this.icon, required this.id});
}

// ignore: must_be_immutable
class GridMenu extends StatelessWidget {
  GridMenu({Key? key}) : super(key: key);

  List<Choice> choices = <Choice>[
    Choice(title: 'Ficha Individual', icon: Icons.account_circle, id: 1),
    Choice(title: 'Meu Plantao', icon: Icons.car_crash, id: 2),
    Choice(title: 'Meu Patrimonio', icon: Icons.attach_money, id: 3),
    Choice(title: 'Contracheques', icon: Icons.request_quote, id: 4),
    Choice(title: 'Plano de Férias', icon: Icons.surfing, id: 5),
    Choice(title: 'Sair', icon: Icons.logout_rounded, id: 6),
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      // decoration: BoxDecoration(color: Colors.red),
      width: width * 0.99,
      height: height * 0.40,
      child: GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 8.0,
        children: List.generate(choices.length, (index) {
          return Center(
            child: SelectCard(choice: choices[index]),
          );
        }),
      ),
    );
  }
}

class SelectCard extends StatelessWidget {
  SelectCard({required this.choice});
  final Choice choice;

  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of(context);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: () {
        if (choice.id == 1) {
          Navigator.of(context).pushReplacementNamed(AppRoutes.PAGE_MILITAR);
        }
        if (choice.id == 2) {
          Navigator.of(context).pushReplacementNamed(AppRoutes.PLANTAO);
        }
        if (choice.id == 3) {
          Navigator.of(context)
              .pushReplacementNamed(AppRoutes.DECLARACOES_IRPF_PAGE);
        }
        if (choice.id == 4) {
          Navigator.of(context)
              .pushReplacementNamed(AppRoutes.CONTRACHEQUE_PAGE);
        }
        if (choice.id == 5) {
          Navigator.of(context).pushReplacementNamed(AppRoutes.FERIASHOME);
        }
        if (choice.id == 6) {
          auth.logout();
          Navigator.of(context).pushReplacementNamed(AppRoutes.AUTH_OR_HOME);
        }
      },
      child: Container(
        width: width * 0.35,
        height: height * 0.20,
        child: Card(
            color: Colors.blue,
            child: Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                        child:
                            Icon(choice.icon, size: 50.0, color: Colors.white)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        choice.title,
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ),
                  ]),
            )),
      ),
    );
  }
}
