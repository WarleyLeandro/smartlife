import 'package:flutter/material.dart';

import '../services/user_service.dart';
import 'home_page.dart';
import 'personal_info.dart';

class updateUser extends StatefulWidget {
  @override
  _updateUserState createState() => _updateUserState();
}

class _updateUserState extends State<updateUser> {
  final newUser = UserRealmService();

  TextEditingController nameInput = TextEditingController();
  TextEditingController ageInput = TextEditingController();
  TextEditingController caloriesInput = TextEditingController();
  TextEditingController weightInput = TextEditingController();
  TextEditingController heightInput = TextEditingController();

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
          'Atualize seu perfil',
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
                    controller: nameInput,
                    decoration: const InputDecoration(
                      hintText: 'Nome',
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(),
                  child: TextField(
                    controller: ageInput,
                    decoration: InputDecoration(
                      hintText: 'Idade',
                    ),
                  ),
                ),
                // Container(
                //   decoration: BoxDecoration(),
                //   child: TextField(
                //     controller: caloriesInput,
                //     decoration: const InputDecoration(
                //       hintText: 'Calorias diárias',
                //     ),
                //   ),
                // ),
                Container(
                  decoration: BoxDecoration(),
                  child: TextField(
                    controller: heightInput,
                    decoration: const InputDecoration(
                      hintText: 'Altura',
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(),
                  child: TextField(
                    controller: weightInput,
                    decoration: const InputDecoration(
                      hintText: 'Peso',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  color: Colors.green,
                  onPressed: () {
                    //TODO: Usar Realm to add...

                    newUser.openRealm();
                    var myData = newUser.getItems();
                    print(myData[0].id);

                    newUser.updateUser(
                        myData[0],
                        myData[0].id,
                        nameInput.text,
                        ageInput.text,
                        caloriesInput.text,
                        weightInput.text,
                        heightInput.text);

                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (_) => personal_info()));
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
