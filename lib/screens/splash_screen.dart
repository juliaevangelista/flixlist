import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flixlist/utils/constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Simulando algum processo de inicialização ou carregamento
    _loadData();
  }

  // Função para simular algum processo de inicialização ou carregamento
  Future<void> _loadData() async {
    // Aguarde por 2 segundos (pode ser substituído por um processo de inicialização real)
    await Future.delayed(Duration(seconds: 2));

    // Navegue para a tela de login após o carregamento
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.gradientStart, AppColors.gradientEnd],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Adicione o seu logo ou imagem aqui
              FlutterLogo(
                size: 100,
              ),
              SizedBox(height: 20),
              Text(
                'Seu App',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 20),
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
