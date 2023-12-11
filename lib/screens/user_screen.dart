import 'package:flutter/material.dart';
import 'package:flixlist/utils/constants.dart';
import 'package:flixlist/services/auth_service.dart'; // Importe a classe de autenticação
import 'package:flixlist/screens/login_screen.dart'; 

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil do Usuário'),
        backgroundColor: AppColors.gradientStart,
      ),
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
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/user_avatar.jpg'),
              ),
              SizedBox(height: 20),
              Text(
                'Nome do Usuário',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
              SizedBox(height: 10),
              Text(
                'user@example.com',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Chamando a função de logout ao pressionar o botão
                  AuthService().logout(); // Substitua pela lógica de logout adequada
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()), // Substitua TelaLogin pelo nome da sua tela de login.
                  );

                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: AppColors.buttonBackground,
                  backgroundColor: AppColors.buttonTextColor,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Sair', style: TextStyle(fontSize: 20)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
