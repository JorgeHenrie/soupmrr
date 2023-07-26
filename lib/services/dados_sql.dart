import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rhmobile/models/efetivacao.dart';
import 'package:rhmobile/models/endereco.dart';
import 'package:rhmobile/models/militar.dart';
import 'package:rhmobile/models/telefone.dart';

class DadosSql {
  //URL DO BANCO SQL
  final _Url = 'http://192.168.190.250/flutter/sigrh';

  Future<String> getPasswordWithMd5(String matricula, String password) async {
    final String url = '${_Url}/loginrh.php?matricula=$matricula';
    final response = await http.get(Uri.parse(Uri.encodeFull(url)));
    String errorResult = 'error';
    try {
      final map = await jsonDecode(response.body);
      final dadosMilitar = map['result'];
      String psw = dadosMilitar[0]['pswd'];
      //Retorna a senha criptografada.
      return psw;
    } catch (error) {
      return errorResult;
    }
  }

  // BUSCA UM MILITAR POR MATRICULA
  Future<Militar?> buscarMilitarBancoByMatricula(String matricula) async {
    final String url = '${_Url}/buscapormatricula.php?matricula=${matricula}';
    final response = await http.get(Uri.parse(Uri.encodeFull(url)));
    try {
      final map = await jsonDecode(response.body);
      final dadosMilitar = map['result'];
      bool existeFoto = dadosMilitar[0]['imagemurl'].toString() ==
              'https://rh.pmrr.net/_lib/file/img//wc2/pix_db/'
          ? false
          : true;
      Militar militarTemp = Militar(
        dataIncorporacao: dadosMilitar[0]['incorporacao'].toString(),
        quadro: dadosMilitar[0]['quadro'].toString(),
        matricula: dadosMilitar[0]['matricula'].toString(),
        postoGraduacao:
            dadosMilitar[0]['postograduacao'].toString().toUpperCase(),
        qra: dadosMilitar[0]['qra'].toString().toUpperCase(),
        nomeCompleto: dadosMilitar[0]['nomecompleto'].toString(),
        imageUrl: existeFoto ? dadosMilitar[0]['imagemurl'].toString() : 'null',
        cpf: dadosMilitar[0]['cpf'].toString(),
        subUnidade: dadosMilitar[0]['subu_descricao'].toString(),
        // endereco: Endereco(
        //   bairro: dadosMilitar[0]['bair_nome'].toString(),
        //   rua: dadosMilitar[0]['concat'].toString(),
        //   numero: dadosMilitar[0]['numero'].toString(),
        //   cep: dadosMilitar[0]['cep'].toString(),
        //   municipio: dadosMilitar[0]['muni_nome'].toString(),
        // ),
        endereco: Endereco(
            Municipio(
              nome: dadosMilitar[0]['muni_nome'].toString(),
              id: dadosMilitar[0]['muni_cod'].toString(),
            ),
            Bairro(
                id: dadosMilitar[0]['bair_cod'].toString(),
                nome: dadosMilitar[0]['bair_nome'].toString()),
            Rua(
              id: dadosMilitar[0]['rua_cod'].toString(),
              nome: dadosMilitar[0]['concat'].toString(),
            ),
            dadosMilitar[0]['numero'].toString(),
            dadosMilitar[0]['cep'].toString()),
      );

      dadosMilitar.forEach((dados) {
        var tipo = Tipos.comum;
        bool value = false;

        if (dados['telefone'] != null) {
          if (dados['poli_cont_whats'] == 1) {
            print('tipo telefone $value');
            tipo = Tipos.whats;
            value = true;
          }

          Telefone tel =
              Telefone(numeroTel: dados['telefone'], tipo: tipo, value: value);
          militarTemp.telefones.add(tel);
        }
      });

      return militarTemp;
    } catch (error) {
      return null;
    }
  }

  Future<bool> adicionaContatos(
      String matricula, String telefone, String possuiwhats) async {
    try {
      final String url =
          '${_Url}/inserecontato.php?matricula=$matricula&telefone=$telefone&possuiwhats=$possuiwhats';
      // ignore: unused_local_variable
      final response = await http.get(Uri.parse(Uri.encodeFull(url)));
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<bool> excluiContatos(String matricula) async {
    try {
      final String url = '${_Url}/deletacontato.php?matricula=${matricula}';
      // ignore: unused_local_variable
      final response = await http.get(Uri.parse(Uri.encodeFull(url)));
      return true;
    } catch (error) {
      return false;
    }
  }

  Future<List<Endereco>> listaEnderecoCompleto(String busca) async {
    final String url = '${_Url}/listaenderecocompleto.php';
    final response = await http.get(Uri.parse(Uri.encodeFull(url)));
    if (response.statusCode == 200) {
      try {
        final List enderecos = json.decode(response.body);
        print(enderecos);

        return enderecos.map((json) => Endereco.fromJson(json)).where((end) {
          final endLower = end.logradouro!.toLowerCase();
          final buscaLower = busca.toLowerCase();

          return endLower.contains(buscaLower);
        }).toList();
      } catch (error) {
        print('error $error');
        throw Exception();
      }
    } else {
      print('status code error');
      throw Exception();
    }
  }

  Future<void> salvarPeriodoFerias(Efetivacao efetivacao) async {
    final response = await http.post(
      Uri.parse('$_Url.json'),
      body: jsonEncode(
        {
          "anoBase": efetivacao.anoBase,
          "dataInicio": efetivacao.dataInicio,
          "dataFim": efetivacao.dataFim,
          "tipoConcessao": efetivacao.tipoConcessao,
        },
      ),
    );
  }
}
