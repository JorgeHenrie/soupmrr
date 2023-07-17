import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rhmobile/widgets/drawer_personalizado.dart';
import 'package:url_launcher/url_launcher.dart';

class AjudaPage extends StatelessWidget {
  const AjudaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajuda DTI'),
      ),
      body: Center(
        child: InkWell(
          onTap: () {
            abrirWhatsApp(
                context: context,
                text:
                    'Olá, tudo bem, gostaria de me cadastrar no aplicativo Escala PMRR?',
                number: '95991298238');
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.40,
            decoration: BoxDecoration(
                color: Colors.blue,
                border: Border.all(width: 0.5),
                borderRadius: BorderRadius.all(Radius.circular(6))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Solicitar Ajuda',
                  style: TextStyle(color: Colors.white),
                ),
                IconButton(
                  onPressed: null,
                  icon: Image.asset('assets/imagens/whatsapp.png'),
                  // color: Colors.orange,
                  tooltip: 'Abrir Whatsapp',
                  iconSize: 30,
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: Drawerpersonalizado(),
    );
  }

  void abrirWhatsApp(
      {required BuildContext context,
      required String text,
      required String number}) async {
    var whatsapp = '+55' + number; //+92xx enter like this
    var whatsappURlAndroid =
        "whatsapp://send?phone=" + whatsapp + "&text=$text";
    var whatsappURLIos = "https://wa.me/$whatsapp?text=${Uri.tryParse(text)}";
    print(whatsapp);
    if (Platform.isIOS) {
      // for iOS phone only
      if (await canLaunchUrl(Uri.parse(whatsappURLIos))) {
        await launchUrl(Uri.parse(
          whatsappURLIos,
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Whatsapp not installed")));
      }
    } else {
      // android , web
      if (await canLaunchUrl(Uri.parse(whatsappURlAndroid))) {
        await launchUrl(Uri.parse(whatsappURlAndroid));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Whatsapp not installed")));
      }
    }
  }
}
