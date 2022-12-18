import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:practice/Pages/receipts.dart';
import 'package:realm/realm.dart';

// import 'package:smartlife/Pages/receipts.dart';
// import 'package:smartlife/auth.dart';

import '../auth.dart';
import '../schemas/user_schema.dart';
import '../services/user_service.dart';
import 'personal_info.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String displayText = 'Referições';
  final fb = FirebaseDatabase.instance;

  Future<void> signOut() async {
    await Auth().signOut();
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

  TextEditingController titleInput = TextEditingController();

  TextEditingController dcaloriesInput = TextEditingController();
  var l;
  var g;
  var k;

  String translateMeal(String currentMeal) {
    switch (currentMeal) {
      case 'lunch':
        return 'Almoço';

      case 'breakfast':
        return 'Café da manhã';

      case 'snaks':
        return 'Lanche';

      case 'dinner':
        return 'Jantar';

      default:
        return "";
    }
  }

  Widget MealImg(String currentMeal) {
    switch (currentMeal) {
      case 'lunch':
        return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
              width: 200,
              height: 100,
              fit: BoxFit.cover,
              'https://images2.nogueirense.com.br/wp-content/uploads/2022/10/design-sem-nome-3-1666189173.png'),
        );

      case 'breakfast':
        return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
              width: 200,
              height: 100,
              fit: BoxFit.cover,
              'https://images.pexels.com/photos/103124/pexels-photo-103124.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
        );

      case 'snaks':
        return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
              width: 200,
              height: 100,
              fit: BoxFit.cover,
              'https://s2.glbimg.com/qGxgSCAGc-qoSdDKLbJn75tMmAw=/smart/e.glbimg.com/og/ed/f/original/2021/12/22/maksim-shutov-pua1on18jno-unsplash.jpg'),
        );

      default:
        return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
              width: 200,
              height: 100,
              fit: BoxFit.cover,
              'https://images.unsplash.com/photo-1519708227418-c8fd9a32b7a2?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80'),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final newUser = UserRealmService();
    newUser.openRealm();

    late RealmResults<UserRealm> myData;

    myData = newUser.getItems();

    return Scaffold(
      appBar: AppBar(
        title: _title(),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0),
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => personal_info(),
                  ),
                ),
                child: const CircleAvatar(
                  radius: 20.0,
                  backgroundImage: NetworkImage(
                      "https://img.freepik.com/free-photo/closeup-shot-curious-pug-gray-wall_181624-39551.jpg?w=996&t=st=1671056246~exp=1671056846~hmac=da68c5f5fd5f80f1d2c00aa52eea119c4451d88a9c533382055ba2e5dc1b671b"),
                ),
              )),
          // TextButton(onPressed: _signOutButton, child: _signOutButton())
        ],
      ),
      body: FirebaseAnimatedList(
        query: fb.ref().child('meals/'),
        defaultChild: const Center(child: CircularProgressIndicator()),
        shrinkWrap: true,
        itemBuilder: (context, snapshot, animation, index) {
          Object? meals = snapshot.value;
          return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
                      child: Text(
                        "Home",
                        style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w900,
                            fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 15.0),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.width * 0.18,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Text(
                                'Olá ${myData[0].name}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 35,
                                    color: Color.fromRGBO(0, 33, 64, 1)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10.0, vertical: 0),
                        child: Text(
                          "Refeições",
                          style: TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 20),
                        )),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 15.0),
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: (meals as dynamic).length,
                            itemBuilder: (BuildContext context, int index) {
                              String currentMeal =
                                  (meals as dynamic).keys.toList()[index];
                              return GestureDetector(
                                onTap: () => {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ReceiptsPage(
                                            selectedMeal: currentMeal,
                                          )))
                                },
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Card(
                                        shadowColor:
                                            Color.fromRGBO(0, 33, 64, 1),
                                        color: Color.fromRGBO(214, 228, 232, 1),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: ListTile(
                                            leading: MealImg(currentMeal),
                                            title: Text(
                                                style: const TextStyle(
                                                    fontSize: 25.0,
                                                    color: Color.fromRGBO(
                                                        0, 33, 64, 1),
                                                    fontWeight: FontWeight.w600,
                                                    overflow:
                                                        TextOverflow.clip),
                                                translateMeal(currentMeal)
                                                    .toString()),
                                          ),
                                        ),
                                      )
                                    ]),
                              );
                            })),
                  ]));
        },
      ),
    );
  }

  upd() async {
    DatabaseReference ref1 =
        FirebaseDatabase.instance.ref("meals/mealsList//$k");

// Only update the name, leave the age and address!
    await ref1.update({
      "title": titleInput.text,
      "calories": dcaloriesInput.text,
    });
    titleInput.clear();
    dcaloriesInput.clear();
  }
}
