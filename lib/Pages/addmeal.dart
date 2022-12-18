import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class addmeal extends StatefulWidget {
  const addmeal({Key? key, this.selectedMeal}) : super(key: key);

  final selectedMeal;

  @override
  _addmealState createState() => _addmealState();
}

class _addmealState extends State<addmeal> {
  TextEditingController titleInput = TextEditingController();
  TextEditingController descriptionInput = TextEditingController();
  TextEditingController caloriesInput = TextEditingController();
  TextEditingController timeInput = TextEditingController();

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

  final fb = FirebaseDatabase.instance;

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
          'Novo Prato',
          style: TextStyle(
              color: Colors.green, fontSize: 25, fontWeight: FontWeight.w800),
        ));
  }

  @override
  Widget build(BuildContext context) {
    print(widget.selectedMeal);
    var rng = Random();
    var id = rng.nextInt(10000);
    final ref = fb.ref().child('meals/mealsList/${widget.selectedMeal}/$id');

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
                  child: TextField(
                    controller: titleInput,
                    decoration: const InputDecoration(
                      hintText: 'Título',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  child: TextField(
                    controller: descriptionInput,
                    decoration: const InputDecoration(
                      hintText: 'Descrição',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  child: TextField(
                    controller: caloriesInput,
                    decoration: const InputDecoration(
                      hintText: 'Calorias',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  child: TextField(
                    controller: timeInput,
                    decoration: const InputDecoration(
                      hintText: 'Tempo',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  color: Colors.green,
                  onPressed: () {
                    ref.set({
                      "name": titleInput.text,
                      "description": descriptionInput.text,
                      "calories": caloriesInput.text,
                      "time": timeInput.text
                    }).asStream();
                    Navigator.pushReplacement(
                        context, MaterialPageRoute(builder: (_) => HomePage()));
                  },
                  child: const Text(
                    "Salvar",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
