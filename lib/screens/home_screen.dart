import 'package:flutter/material.dart';
import 'package:flixlist/utils/constants.dart';
import 'search_screen.dart';
import 'user_screen.dart';
import 'package:flixlist/widgets/movie_grid.dart';
import 'package:flixlist/models/movie.dart';
import 'add_movie_screen.dart';
import 'package:flixlist/services/imdb_services.dart';
import 'package:flixlist/screens/edit_movie_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  List<Movie> movies = [];
  ImdbService imdbService = ImdbService(); // Certifique-se de importar a classe ImdbService

  @override
  void initState() {
    super.initState();
    // Carregue os filmes ao iniciar a tela (pode ser uma lista predefinida ou vazia)
    loadMovies();
  }
  void deleteMovie(String id) {
      setState(() {
        movies.removeWhere((movie) => movie.id == id);
      });
    }
  Future<void> loadMovies() async {
    // Substitua a chamada para carregar filmes da lista estática
    movies = getStaticMoviesList();
    setState(() {});
  }

  List<Movie> getStaticMoviesList() {
    // Adicione filmes à lista estática
    return [
      Movie(id: '1', title: 'Filme 1', image: 'aa', description: 'Descrição do Filme 1', status: 'Minha Lista'),
      Movie(id: '2', title: 'Filme 2', image: 'aa', description: 'Descrição do Filme 2', status: 'Assistindo'),
      Movie(id: '3', title: 'Filme 3', image: 'aa', description: 'Descrição do Filme 3', status: 'Assistido'),
    ];
  }
  

  void showMovieDetails(Movie? movie) {
    if (movie != null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(movie.title),
            content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Descrição: ${movie.description}'),
              Text('Status: ${movie.status}'),
            ],
          ),
            actions: [
            ElevatedButton(
              onPressed: () async {
                // Chame a tela de edição e aguarde o resultado
                var result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditMovieScreen(movie: movie)),
                );

                // Atualize a lista de filmes se houver alterações
                if (result != null && result is Movie) {
                  // Atualize o filme na lista
                  movies[movies.indexWhere((element) => element.id == movie.id)] = result;
                  setState(() {});
                }
              },
              child: Text('Editar'),
            ),
            SizedBox(width: 8), // Adiciona um espaçamento entre os botões
            ElevatedButton(
            onPressed: () {
              deleteMovie(movie.id);
            },
            child: Text('Excluir'),
          ),


              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Fechar'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.gradientStart, AppColors.gradientEnd],
          ),
        ),
        child: MovieGrid(
          movies: movies,
          onMovieTap: (movie) => showMovieDetails(movie as Movie?),
        ),

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Navegue para a tela de adição de filme
          var result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddMovieScreen()),
          );

          // Debug: Imprima o resultado
          print(result);

          // Atualize a lista de filmes quando retornar da tela de adição
          if (result != null && result is Movie) {
            // Adicione o filme à lista de filmes
            movies.add(result);
            setState(() {});
          }
        },
        child: Icon(Icons.add),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          switch (index) {
            case 0:
              // Mantenha a navegação para a tela Home
              break;
            case 1:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchScreen()),
              );
              break;
            case 2:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserScreen()),
              );
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Pesquisar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Usuário',
          ),
        ],
      ),
    );
  }
}

