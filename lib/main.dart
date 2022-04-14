import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  //Extends - Herança
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController etanolController = TextEditingController();
  TextEditingController gasolinaController = TextEditingController();
  String _resultado = "First Project with Flutter on Android Studio";
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // _ Serve para deixar a variável reservada

  void _calculaCombustivelIdeal() {
    double vEtanol = double.parse(etanolController.text.replaceAll(',', '.'));
    double vGasolina =
        double.parse(gasolinaController.text.replaceAll(',', '.'));

    double proporcao = vEtanol / vGasolina;

    // if(proporcao <= 0.7){
    //   _resultado = "Abasteça com Etanol";
    // } else {
    //   _resultado = "Abasteça com Gasolina";
    // }

    setState(() {
      _resultado = (proporcao <= 0.7)
          ? "Abasteça com Etanol (Proporção: ${proporcao.toStringAsFixed(2).replaceAll('.', ',')})"
          : "Abasteça com Gasolina (Proporção: ${proporcao.toStringAsFixed(2).replaceAll('.', ',')})";
    });
    //Lógica usada: Se a proporção for maior do que 0,7, então deve-se abastecer com Gasolina
  }

  void _reset() {
    etanolController.text = "";
    gasolinaController.text = "";
    setState(() {
      _resultado = "Informe os Valores";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Etanol ou Gasolina Android Studio",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.pink[900],
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              _reset();
            },
          )
        ],
      ),
      body: SingleChildScrollView(
          //Pequeno afastamento das bordas de celulares com tela infinita.
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    Icons.local_gas_station_outlined,
                    size: 130,
                    color: Colors.pinkAccent,
                  ),
                  TextFormField(
                    controller: etanolController,
                    textAlign: TextAlign.center,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                        labelText: "Valor do Etanol",
                        labelStyle: TextStyle(color: Colors.pink)),
                    style: TextStyle(color: Colors.pinkAccent, fontSize: 26),
                    validator: (value) {
                      return (value == null || value.isEmpty)
                          ? "Informe o valor do Etanol!"
                          : null;
                    },
                  ),
                  SizedBox(height: 25),
                  TextFormField(
                    controller: gasolinaController,
                    textAlign: TextAlign.center,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                        labelText: "Valor da Gasolina",
                        labelStyle: TextStyle(color: Colors.pinkAccent)),
                    style: TextStyle(color: Colors.pink, fontSize: 26),
                    validator: (value) {
                      return (value == null || value.isEmpty)
                          ? "Informe o valor da Gasolina!"
                          : null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 20),
                    child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          child: const Text(
                            "Verificar",
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.pinkAccent),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _calculaCombustivelIdeal();
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                        title: const Text("Resultado"),
                                        content: Text(_resultado),
                                        actions: [
                                          TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context, "Ok"),
                                              child: const Text("Ok"))
                                        ],
                                      ));
                            }
                          },
                        )),
                  ),
                  Text(
                    _resultado,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.pink, fontSize: 24),
                  )
                ],
              ))),
    );
  }
}
