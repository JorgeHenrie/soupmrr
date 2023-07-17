import 'package:flutter/material.dart';

import 'package:rhmobile/pages/Pdf_Viewer_Page.dart';

import 'package:rhmobile/widgets/drawer_personalizado.dart';

class Contracheque extends StatefulWidget {
  const Contracheque({Key? key}) : super(key: key);

  @override
  _ContrachequeState createState() => _ContrachequeState();
}

class _ContrachequeState extends State<Contracheque> {
  String? _anoSelecionado;
  bool anoSelecionado = false;
  final _anos = ['2022', '2021', '2020', '2019'];

  @override
  Widget build(BuildContext context) {
    double hieght = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Contracheques'),
      ),
      body: Container(
        width: width,
        height: hieght,
        // decoration: BoxDecoration(color: Colors.black),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: DropdownButton<String>(
                  hint: const Text("Selecione"),
                  style: const TextStyle(color: Colors.blue),
                  alignment: AlignmentDirectional.center,
                  items: _anos.map((String dropDownStringItem) {
                    return DropdownMenuItem<String>(
                      value: dropDownStringItem,
                      alignment: AlignmentDirectional.center,
                      child: Container(
                          width: width * 0.16, child: Text(dropDownStringItem)),
                    );
                  }).toList(),
                  onChanged: ((novoItemSelecionado) {
                    _dropDownItemSelected(novoItemSelecionado!);
                    anoSelecionado = true;

                    setState(() {
                      _anoSelecionado = novoItemSelecionado;
                    });
                  }),
                  value: _anoSelecionado),
            ),
            SizedBox(height: hieght * 0.05),
            anoSelecionado == true
                ? Container(
                    height: hieght * 0.50,
                    // decoration: BoxDecoration(color: Colors.blue),
                    width: width * 0.95,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(color: Colors.blue),
                          height: hieght * 0.06,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  'Dezembro',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              IconButton(
                                iconSize: 10,
                                onPressed: () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PdfViewerPage(
                                          pdfPath: 'assets/contracheque.pdf'),
                                    ),
                                  );
                                },
                                icon: Image.asset('assets/imagens/pdf.png'),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(color: Colors.blue),
                          height: hieght * 0.06,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  'Novembro',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              IconButton(
                                iconSize: 10,
                                onPressed: () async {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PdfViewerPage(
                                          pdfPath: 'assets/contracheque2.pdf'),
                                    ),
                                  );
                                },
                                icon: Image.asset('assets/imagens/pdf.png'),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
          ],
        ),
      ),
      drawer: Drawerpersonalizado(),
    );
  }

  void _dropDownItemSelected(String novoItem) {
    setState(() {
      _anoSelecionado = novoItem;
    });
  }
}
