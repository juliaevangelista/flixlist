// screens/add_movie_screen.dart

import 'package:flutter/material.dart';
import 'package:flixlist/models/movie.dart';
import 'package:flixlist/services/imdb_services.dart';
import 'package:flixlist/screens/edit_movie_screen.dart';

class AddMovieScreen extends StatelessWidget {
  final ImdbService imdbService = ImdbService();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Filme/Série'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Descrição'),
            ),
            TextField(
              controller: imageController,
              decoration: InputDecoration(labelText: 'URL da Imagem'),
            ),
            ElevatedButton(
              onPressed: () {
                // Crie um novo filme com os dados do formulário
                Movie newMovie = Movie(
                  id: DateTime.now().toString(),
                  title: titleController.text,
                  description: descriptionController.text,
                  image: imageController.text,
                  status: 'Minha Lista', // Defina um status padrão, por exemplo, 'Minha Lista'
                );

                // Adicione o filme usando o serviço
                imdbService.addMovie(newMovie);
                

                // Feche a tela de adição
                Navigator.pop(context, newMovie);
              },
              child: Text('Adicionar Filme'),
            ),

          ],
        ),
      ),
    );
  }
}
