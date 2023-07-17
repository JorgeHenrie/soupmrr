import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rhmobile/services/dados_sql.dart';
import 'package:rhmobile/view/second_screen.dart';
import 'package:rhmobile/widgets/dados_militar.dart';
import 'package:rhmobile/widgets/drawer_personalizado.dart';
import '../models/auth_model.dart';
import '../models/militar.dart';

class PageMilitar extends StatefulWidget {
  const PageMilitar({Key? key}) : super(key: key);

  @override
  _PageMilitarState createState() => _PageMilitarState();
}

class _PageMilitarState extends State<PageMilitar> {
  @override
  Widget build(BuildContext context) {
    Auth auth = Provider.of(context);

    DadosSql dadosSql = DadosSql();

    late Militar? militar;

    //Busca os dados do militar no banco de dados
    Future<Militar?> _buscaDadosSql() async {
      militar = await dadosSql.buscarMilitarBancoByMatricula(auth.matricula!);

      return militar;
    }

    return FutureBuilder<Militar?>(
      future: _buscaDadosSql(),
      builder: ((context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              flexibleSpace: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.lightBlue,
                      Colors.blue.shade900,
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.topRight,
                  ),
                ),
              ),
              title: Text('Ficha Individual'),
            ),
            drawer: Drawerpersonalizado(),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: DadosMilitar(
                militar: militar!,
              ),
            ),
          );
        } else if (snapshot.hasError) {
          // return Center(
          //     child: Text(
          //         'Erro de Conexao, Entre em contato com o suporte ${snapshot.error}'));
          return SecondScreen();
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}
