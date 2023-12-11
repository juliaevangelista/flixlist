import 'package:flutter/material.dart';
import 'package:flixlist/models/movie.dart';

class MovieGrid extends StatelessWidget {
  final List<Movie> movies;
  final void Function(Movie) onMovieTap;

  MovieGrid({required this.movies, required this.onMovieTap});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            // Chama a função de callback quando um filme é tocado
            onMovieTap(movies[index]);
          },
          child: Container(
            color: Colors.white,
            child: Center(
              child: Text(
                movies[index].title,
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ),
          ),
        );
      },
    );
  }
}
