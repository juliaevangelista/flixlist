import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class LocalStorage {
  late Database _database;

  Future<void> initDatabase() async {
    // Obtém o diretório de documentos do dispositivo
    final documentsDirectory = await getApplicationDocumentsDirectory();
    
    // Concatena o caminho do banco de dados ao diretório de documentos
    final path = join(documentsDirectory.path, 'local_database.db');

    // Abre (ou cria, se não existir) o banco de dados
    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        // Cria a tabela se ela não existir
        await db.execute(
          'CREATE TABLE user(id INTEGER PRIMARY KEY, name TEXT, email TEXT, password TEXT)',
        );
      },
    );
  }

  Future<void> insertUser({required String name, required String email, required String password}) async {
    // Insere um usuário na tabela
    await _database.insert(
      'user',
      {'name': name, 'email': email, 'password': password},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    // Obtém todos os usuários da tabela
    return await _database.query('user');
  }
}
