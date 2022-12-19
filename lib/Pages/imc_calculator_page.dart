import 'package:flutter/material.dart';
import '../services/user_service.dart';
import 'home_page.dart';
import 'personal_info.dart';

class imcCalculator extends StatefulWidget {
  @override
  _imcCalculatorState createState() => _imcCalculatorState();
}

class _imcCalculatorState extends State<imcCalculator> {
  TextEditingController weightInput = TextEditingController();
  TextEditingController heightInput = TextEditingController();

  double _respIMC = 0.0;

  void calcularImc(double peso, double altura) {
    setState(() {
      _respIMC = peso / (altura * altura);
    });
  }

  Future<bool?> showWarning(BuildContext context) async => showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
            title: Text('Desejar sair?'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text('Não'),
              ),
              ElevatedButton(
                  onPressed: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => HomePage()),
                      (Route<dynamic> route) => false),
                  child: Text('Sim'))
            ],
          ));

  Widget _title() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: const [
        Text(
          'SMARTLIFE',
          style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
        ),
        Icon(
          Icons.energy_savings_leaf,
          color: Colors.green,
        ),
      ],
    );
  }

  Widget _PageTitle() {
    return const Padding(
        padding: EdgeInsets.only(bottom: 20.0, left: 20.00, right: 20.00),
        child: Text(
          'Calcular IMC',
          style: TextStyle(
              color: Colors.green, fontSize: 25, fontWeight: FontWeight.w800),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          final shouldPopAlert = await showWarning(context);
          return shouldPopAlert ?? false;
        },
        child: Scaffold(
          appBar: AppBar(
            leading: const BackButton(
              color: Colors.green,
            ),
            elevation: 0,
            centerTitle: true,
            title: _title(),
            backgroundColor: Colors.white,
          ),
          body: Container(
            height: double.infinity,
            width: double.infinity,
            padding:
                const EdgeInsets.only(top: 20.00, left: 20.00, right: 20.00),
            child: Column(
              children: [
                _PageTitle(),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(),
                  child: TextField(
                    controller: heightInput,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Altura',
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(),
                  child: TextField(
                    controller: weightInput,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Peso',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                MaterialButton(
                  color: Colors.green,
                  onPressed: () {
                    double peso = double.parse(weightInput.text);
                    double altura = double.parse(heightInput.text);
                    calcularImc(peso, altura);
                  },
                  child: const Text(
                    "Calcular",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Seu IMC:  ${_respIMC.toStringAsPrecision(4)}',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Colors.grey),
                ),
              ],
            ),
          ),
        ));
  }
}
