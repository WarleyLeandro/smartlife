import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../auth.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? errorMessage = '';
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth()
          .signInWithEmailAndPassword(
            email: _controllerEmail.text,
            password: _controllerPassword.text,
          )
          .then((value) => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              ));
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _entryField(
    String title,
    TextEditingController controller,
    obscure,
  ) {
    return TextField(
      obscureText: obscure,
      controller: controller,
      decoration: InputDecoration(
        labelText: title,
      ),
    );
  }

  Widget image() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Image.network(
              'https://www.helpguide.org/wp-content/uploads/calories-counting-diet-food-control-and-weight-loss-concept-calorie-768.jpg')
        ]));
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : 'Erro: ? $errorMessage');
  }

  Widget _submitButton() {
    return ElevatedButton(
      onPressed:
          isLogin ? signInWithEmailAndPassword : createUserWithEmailAndPassword,
      child: Text(isLogin ? 'Entrar' : 'Registrar'),
    );
  }

  Widget _loginOrRegisterButton() {
    return TextButton(
      onPressed: () {
        setState(() {
          isLogin = !isLogin;
        });
      },
      child: Text(isLogin ? 'Novo Usuario?' : 'Realizar Login'),
    );
  }

  Widget _loginOrRegisterSubTitle() {
    return Padding(
        padding: const EdgeInsets.only(bottom: 20.0, left: 20.00, right: 20.00),
        child: Text(
          isLogin
              ? 'Acesse sua conta fazendo login abaixo'
              : 'Crie sua conta preenchendo as informações abaixo.',
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Color.fromRGBO(0, 33, 64, 1),
              fontSize: 18,
              fontWeight: FontWeight.w400),
        ));
  }

  Widget _loginOrRegisterTitle() {
    return Padding(
        padding: const EdgeInsets.only(bottom: 20.0, left: 20.00, right: 20.00),
        child: Text(
          isLogin ? 'Bem vindo' : 'Registre-se',
          style: const TextStyle(
              color: Colors.green, fontSize: 40, fontWeight: FontWeight.w800),
        ));
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
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.only(top: 0, left: 20.00, right: 20.00),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // image(),
            _loginOrRegisterTitle(),
            _loginOrRegisterSubTitle(),
            _entryField('email', _controllerEmail, false),
            _entryField('senha', _controllerPassword, true),
            _errorMessage(),
            _submitButton(),
            _loginOrRegisterButton(),
          ],
        ),
      ),
    );
  }
}
