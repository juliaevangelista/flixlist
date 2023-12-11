import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flixlist/models/user.dart';

class AuthService {
  static late Database _database;
  bool _isAuthenticated = false;

  Future<void> initDatabase() async {
    try {
      _database = await openDatabase(
        join(await getDatabasesPath(), 'local_database.db'), // Alterei a extensão para ".db"
        version: 1,
        onCreate: (db, version) async {
          await db.execute(User.createTableQuery);
        },
      );
    } catch (e) {
      print('Erro ao inicializar o banco de dados: $e');
      // Adicione tratamento de erro, se necessário
    }
  }

  Future<void> registerUser(User user) async {
    try {
      if (_database == null) {
        print('Erro: Banco de dados não inicializado.');
        // Adicione tratamento de erro, se necessário
        return;
      }

      // Verifica se a tabela 'users' existe no banco de dados
      bool tableExists = await doesTableExist(_database, User.tableName);
      if (!tableExists) {
        print('Erro: Tabela ${User.tableName} não encontrada.');
        // Adicione tratamento de erro, se necessário
        return;
      }

      // Insere o usuário na tabela 'users'
      await _database.insert(User.tableName, user.toJson());
      print('Usuário registrado com sucesso.');
    } catch (e) {
      print('Erro ao registrar usuário: $e');
      // Adicione tratamento de erro, se necessário
    }
  }

  Future<bool> doesTableExist(Database db, String tableName) async {
    var result = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table' AND name='$tableName';",
    );
    return result.isNotEmpty;
  }

  Future<User?> loginUser(String email, String password) async {
    try {
      if (_database == null) {
        // Adicione tratamento de erro, se necessário
        return null;
      }

      List<Map<String, Object?>>? result = await _database.query(
        User.tableName,
        where: 'email = ? AND password = ?',
        whereArgs: [email, password],
      );

      if (result?.isNotEmpty ?? false) {
        _isAuthenticated = true;
        return User.fromJson(result!.first);
      }
    } catch (e) {
      print('Erro ao fazer login: $e');
      // Adicione tratamento de erro, se necessário
    }

    return null;
  }

  Future<void> logout() async {
    // Adicione a lógica para limpar os dados de autenticação.
    _isAuthenticated = false;
  }

  bool get isAuthenticated => _isAuthenticated;
}
