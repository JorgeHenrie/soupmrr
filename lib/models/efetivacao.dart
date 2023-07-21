import 'package:rhmobile/models/militar.dart';

enum status {
  solicitada,
  naoSolicitada,
}

enum tipoConcessao {
  integral,
  parcelada,
}

class Efetivacao {
  final String id;
  final DateTime anoBase;
  Militar policialMilitar;
  //TipoConcessao tipoConcessao;
  DateTime dataInicio;
  DateTime dataFim;
  final bool autorizacao;
  final String parcela;
  final Enum status;
  Enum tipoConcessao;
  //ANEXO DO ACRÉSCIMO

  Efetivacao({
    required this.id,
    required this.anoBase,
    required this.policialMilitar,
    //required this.tipoConcessao,
    required this.dataInicio,
    required this.dataFim,
    required this.autorizacao,
    required this.parcela,
    required this.status,
    required this.tipoConcessao,
  });

  //Criar uma efetivação a partir de um Map
  // Efetivacao.fromMap(Map<String, dynamic> map) {
  //   return Efetivacao(
  //     id: map['id'],
  //     anoBase: map['anoBase'],
  //     //policialMilitar: map['policialMilitar'],
  //     dataInicio: dataInicio,
  //     dataFim: dataFim,
  //     autorizacao: autorizacao,
  //     parcela: parcela,
  //     status: status,
  //     tipoConcessao: tipoConcessao,
  //   );
}
