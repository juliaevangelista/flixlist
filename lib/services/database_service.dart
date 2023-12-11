import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flixlist/models/movie.dart';

class DatabaseService {
  late Database _database;

  Future<void> open() async {
    if (_database.isOpen) return;

    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'movies_database.db');

    _database = await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE movies (
        id TEXT PRIMARY KEY,
        title TEXT,
        description TEXT,
        image TEXT,
        status TEXT
      )
    ''');
  }

  Future<void> insertMovie(Movie movie) async {
    await _database.insert('movies', movie.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Movie>> getMovies() async {
    final List<Map<String, dynamic>> maps = await _database.query('movies');
    return List.generate(maps.length, (i) {
      return Movie(
        id: maps[i]['id'],
        title: maps[i]['title'],
        description: maps[i]['description'],
        image: maps[i]['image'],
        status: maps[i]['status'],
      );
    });
  }

  Future<void> updateMovie(Movie movie) async {
    await _database.update(
      'movies',
      movie.toMap(),
      where: 'id = ?',
      whereArgs: [movie.id],
    );
  }

  Future<void> deleteMovie(String id) async {
    await _database.delete(
      'movies',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> close() async {
    await _database.close();
  }
}
void addMovieToDatabase(Movie movie) async {
  final databaseService = DatabaseService();
  await databaseService.open();
  await databaseService.insertMovie(movie);
  await databaseService.close();
}

void updateMovieInDatabase(Movie movie) async {
  final databaseService = DatabaseService();
  await databaseService.open();
  await databaseService.updateMovie(movie);
  await databaseService.close();
}

void deleteMovieFromDatabase(String id) async {
  final databaseService = DatabaseService();
  await databaseService.open();
  await databaseService.deleteMovie(id);
  await databaseService.close();
}
