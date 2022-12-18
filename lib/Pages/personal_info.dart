import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:realm/realm.dart';

import '../auth.dart';
import 'login_register_page.dart';
import '../schemas/user_schema.dart';
import '../services/user_service.dart';
import 'constants.dart';
import 'updateUser.dart';

class personal_info extends StatefulWidget {
  @override
  _personal_infoState createState() => _personal_infoState();
}

class _personal_infoState extends State<personal_info> {
  TextEditingController titleInput = TextEditingController();
  TextEditingController descriptionInput = TextEditingController();
  TextEditingController caloriesInput = TextEditingController();
  TextEditingController timeInput = TextEditingController();

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget _signOutButton() {
    return TextButton(
      onPressed: signOut,
      child: Text('Logout'),
    );
  }

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

  double bmr(peso, altura, idade) {
    return (10 * peso) + (6.25 * altura) - (5 * idade) + 5;
  }

  double tdee(peso, altura, idade) {
    return bmr(peso, altura, idade) * 1.55;
  }

  double totalCalories(peso, altura, idade) {
    return tdee(peso, altura, idade);
  }

  @override
  Widget build(BuildContext context) {
    final newUser = UserRealmService();

    newUser.openRealm();

    late RealmResults<UserRealm> myData;

    myData = newUser.getItems();

    var altura = double.parse(myData[0].height);
    var peso = int.parse(myData[0].weight);

    var respIMC = myData.isEmpty ? 25.000 : peso / (pow(altura, 2));

    var respCalories = totalCalories(peso, altura, int.parse(myData[0].age));

    print(respCalories);

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.green,
        ),
        title: _title(),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20.0, left: 20.00, right: 20.00),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: kToolbarHeight + 55,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [],
              ),
            ),
            Center(
              child: Hero(
                tag: 136265974,
                child: CircleAvatar(
                  radius: MediaQuery.of(context).size.width / 8,
                  backgroundImage: NetworkImage(Contantes.animalUser),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Center(
              child: Text(
                '${myData[0].name}',
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 30,
                    color: Color.fromRGBO(0, 33, 64, 1)),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "Meus dados:",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 25,
                        color: Color.fromRGBO(0, 33, 64, 1)),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Idade: ${myData[0].age} anos',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Colors.grey),
                  ),
                  // Text(
                  //   'Calorias diárias: ${myData[0].calories} kcals',
                  //   style: TextStyle(
                  //       fontWeight: FontWeight.w600,
                  //       fontSize: 20,
                  //       color: Colors.grey),
                  // ),
                  Text(
                    'Caloria diária ideal: ${respCalories.toStringAsPrecision(5)} kcals',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Colors.grey),
                  ),
                  Text(
                    'Peso: ${myData[0].weight} kg',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Colors.grey),
                  ),
                  Text(
                    'Minha altura:  ${myData[0].height} cm',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Colors.grey),
                  ),
                  Text(
                    'IMC:  ${respIMC.toStringAsPrecision(4)}',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
            Center(
              child: FloatingActionButton.extended(
                shape: const StadiumBorder(
                    side: BorderSide(color: Colors.green, width: 1)),
                onPressed: () => {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => updateUser(),
                    ),
                  )
                },
                backgroundColor: Colors.green,
                label: Container(
                  width: MediaQuery.of(context).size.width / 3,
                  child: const Center(
                    child: Text(
                      "Editar Perfil",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () => {
                  signOut,
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                      (route) => false)
                },
                child: const Text('Logout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
