import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IMC com Idade',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _pesoController = TextEditingController();
  final _alturaController = TextEditingController();
  final _idadeController = TextEditingController();
  String _resultado = '';

  void _calcularIMC() {
    setState(() {
      double peso = double.tryParse(_pesoController.text) ?? 0;
      double altura = double.tryParse(_alturaController.text) ?? 0;
      int idade = int.tryParse(_idadeController.text) ?? 0;

      if (altura == 0) {
        _resultado = 'Altura inválida!';
        return;
      }

      double imc = peso / (altura * altura);
      String classificacao = classificarIMC(imc, idade);
      String faixaClassificacao = faixaIMC(imc);

      _resultado = '''
        IMC: ${imc.toStringAsFixed(2)}
        Classificação: $classificacao ($faixaClassificacao)

        Dicas de saúde:
        ${dicasSaude(classificacao)}
      ''';
    });
  }

  String classificarIMC(double imc, int idade) {
    if (idade < 18) {
      // CRIANÇA E ADOESCENTE
      if (imc < 15) {
        return "Abaixo do Peso";
      } else if (imc < 21) {
        return "Normal";
      } else if (imc < 25) {
        return "Sobrepeso";
      } else {
        return "Obesidade";
      }
    } else {
      // ADULTO
      if (imc < 18.5) {
        return "Abaixo do Peso";
      } else if (imc < 25) {
        return "Normal";
      } else if (imc < 30) {
        return "Sobrepeso";
      } else {
        return "Obesidade";
      }
    }
  }

  String faixaIMC(double imc) {
    if (imc < 18.5) {
      return "17 kg ou menos";
    } else if (imc < 25) {
      return "18,5 kg a 24,9 kg";
    } else if (imc < 30) {
      return "25 kg a 29,9 kg";
    } else if (imc < 35) {
      return "30 kg a 34,9 kg";
    } else {
      return "35 kg ou mais";
    }
  }

  String dicasSaude(String classificacao) {
    switch (classificacao) {
      case "Abaixo do Peso":
        return "Não saudavel";
      case "Normal":
        return "Saudavel!";
      case "Sobrepeso":
        return "Não saudavel";
      case "Obesidade":
        return "Não saudavel";
      default:
        return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IMC com Idade'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _pesoController,
              decoration: InputDecoration(
                labelText: 'Peso (kg)',
                hintText: 'Ex: 70.5',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                errorText: _pesoController.text.isEmpty ? 'Informe o peso' : null,
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 15),
            TextField(
              controller: _alturaController,
              decoration: InputDecoration(
                labelText: 'Altura (m)',
                hintText: 'Ex: 1.75',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                errorText: _alturaController.text.isEmpty ? 'Informe a altura' : null,
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 15),
            TextField(
              controller: _idadeController,
              decoration: InputDecoration(
                labelText: 'Idade (anos)',
                hintText: 'Ex: 30',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                errorText: _idadeController.text.isEmpty ? 'Informe a idade' : null,
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _calcularIMC,
              child: Text('Calcular IMC'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                _resultado,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
