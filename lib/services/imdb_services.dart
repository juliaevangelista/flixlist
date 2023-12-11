import 'package:flixlist/models/movie.dart';

class ImdbService {
  // Suponha que você tenha uma lista de filmes no serviço
  List<Movie> _movies = [];

  // Método para adicionar um filme à lista
  void addMovie(Movie movie) {
    _movies.add(movie);
    // Aqui você normalmente chamaria o método para adicionar ao banco de dados, por exemplo:
    // _yourDatabaseService.addMovieToDatabase(movie);
  }
  void deleteMovieById(String id) {
    _movies.removeWhere((movie) => movie.id == id);
  }
  // Outros métodos do serviço...
}
