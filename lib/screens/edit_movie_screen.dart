import 'package:flutter/material.dart';
import 'package:flixlist/models/movie.dart'; // Importe a classe Movie

class EditMovieScreen extends StatefulWidget {
  final Movie movie;

  const EditMovieScreen({Key? key, required this.movie}) : super(key: key);

  @override
  _EditMovieScreenState createState() => _EditMovieScreenState();
}

class _EditMovieScreenState extends State<EditMovieScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _imageController = TextEditingController(); // Adicione este controlador

  @override
  void initState() {
    super.initState();
    // Inicialize os controladores com os detalhes atuais do filme
    _titleController.text = widget.movie.title;
    _descriptionController.text = widget.movie.description;
    _statusController.text = widget.movie.status;
    _imageController.text = widget.movie.image; // Inicialize com o valor atual da imagem
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Filme'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Descrição'),
            ),
            TextField(
              controller: _imageController, // Use o controlador da imagem
              decoration: InputDecoration(labelText: 'Imagem'),
            ),
            TextField(
              controller: _statusController,
              decoration: InputDecoration(labelText: 'Status'),
            ),
            ElevatedButton(
              onPressed: () {
                // Crie um novo filme com os dados atualizados
                Movie updatedMovie = Movie(
                  id: widget.movie.id,
                  title: _titleController.text,
                  description: _descriptionController.text,
                  image: _imageController.text, // Use o valor do controlador da imagem
                  status: _statusController.text,
                );

                // Retorne o filme atualizado para a tela principal
                Navigator.pop(context, updatedMovie);
              },
              child: Text('Salvar Alterações'),
            ),
          ],
        ),
      ),
    );
  }
}
