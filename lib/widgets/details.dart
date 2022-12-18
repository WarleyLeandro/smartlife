import 'package:flutter/material.dart';
// import 'package:smartlife/auth.dart';
// import 'package:smartlife/Pages/personal_info.dart';

import '../Pages/personal_info.dart';
import '../auth.dart';

class ReceiptDetailsPage extends StatefulWidget {
  const ReceiptDetailsPage({super.key, required this.selectedReceipted});

  final selectedReceipted;

  @override
  State<ReceiptDetailsPage> createState() => _ReceiptDetailsPageState();
}

class _ReceiptDetailsPageState extends State<ReceiptDetailsPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: _title(),
          leading: const BackButton(
            color: Colors.green,
          ),
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
                ))
            // TextButton(onPressed: _signOutButton, child: _signOutButton())
          ],
        ),
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                      widget.selectedReceipted['image'] ??
                          'https://blog.mundoverde.com.br/wp-content/uploads/2016/06/shutterstock_328934594.jpg',
                    )
                  ])),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
            child:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 0, vertical: 20.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${widget.selectedReceipted['name']}',
                          style: const TextStyle(
                              fontSize: 30,
                              fontFamily: 'Quicksand',
                              color: Color.fromRGBO(0, 33, 64, 1),
                              fontWeight: FontWeight.bold))
                    ]),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 0, vertical: 0.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('KCAL',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          )),
                      Text('${widget.selectedReceipted['calories']}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          )),
                    ]),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 0, vertical: 10.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Tempo',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          )),
                      Text('${widget.selectedReceipted['time']} MIN',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          )),
                    ]),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 0, vertical: 10.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Preparo',
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Quicksand',
                              color: Color.fromRGBO(0, 33, 64, 1),
                              fontWeight: FontWeight.w900)),
                      Text(
                        textAlign: TextAlign.justify,
                        '${widget.selectedReceipted['description']}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                    ]),
              ),
            ]),
          ),
        ]));
  }
}
