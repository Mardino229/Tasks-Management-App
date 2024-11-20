

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'model.dart';

class TodoDatabaseService {
  static final TodoDatabaseService _instance = TodoDatabaseService._internal();
  static Database? _database;

  factory TodoDatabaseService() {
    return _instance;
  }

  TodoDatabaseService._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'tasks.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    print("ca a marché?");
    await db.execute(
      'CREATE TABLE todo(id INTEGER PRIMARY KEY , name TEXT, description TEXT, statut TEXT)',
    );
  }

  Future<void> insertData(Todo data) async {
    final db = await database;
    await db.insert('todo', data.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Todo> getById (int id) async {
    final db = await database;
    final List<Map<String, Object?>> todo = await db.query("todo",
        where: 'id = ?',
        whereArgs: [id]
    );
    if(todo.isNotEmpty) {
      Map<String, Object?> first = todo.first;
      return Todo.fromMap(first);
    }
    return Todo(id:0, name: "", description: "", statut: "");

  }
  Future<List<Todo>> getByStatut (String statut) async {
    final db = await database;
    final List<Map<String, Object?>> todo = await db.query("todo",
        where: 'statut = ?',
        whereArgs: [statut]
    );
    return [
      for (final {
      'id' : id as int,
      'name': name as String,
      'description' : description as String,
      'statut' : statut as String,
      } in todo)
        Todo(id: id, name: name, description: description, statut: statut),
    ];
  }

  Future<List<Todo>> getData() async {
    final db = await database;
    final List<Map<String, Object?>> todoMaps = await db.query('todo');
    return [
      for (final {
      'id' : id as int,
      'name': name as String,
      'description' : description as String,
      'statut' : statut as String,
      } in todoMaps)
        Todo(id: id, name: name, description: description, statut: statut),
    ];
  }


  Future<void> updateTodo(Todo todo) async {
    // Get a reference to the database.
    final db = await database;
    // Update the given Dog.
    await db.update(
      'todo',
      todo.toMap(),
      // Ensure that the Dog has a matching id.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [todo.id],
    );
  }

  Future<int> updateTodoStatus(int id, String newStatus) async {
    final db = await database;

    final result = await db.update(
      'todo',
      {'statut': newStatus},
      where: 'id = ?',
      whereArgs: [id],
    );

    return result; // Renvoie 1 si la mise à jour a réussi, sinon 0
  }

  Future<void> deleteTodo(int id) async {
    final db = await database;
    await db.delete('todo',
        where: 'id = ?',
        whereArgs: [id]
    );
  }
}

class UserDatabaseService {
  static final UserDatabaseService _instance = UserDatabaseService._internal();
  static Database? _database;

  factory UserDatabaseService() {
    return _instance;
  }

  UserDatabaseService._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'tasks.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE user (id INTEGER PRIMARY KEY , fullName TEXT, email TEXT, password TEXT)',
    );
    await db.execute(
      'CREATE TABLE todo(id INTEGER PRIMARY KEY , name TEXT, description TEXT, statut TEXT)',
    );
  }

  Future<int> registerUser(String fullName, String mail, String password) async {
    final db = await database;

    // Vérification si l'utilisateur existe déjà
    final existingUser = await db.query(
      'user',
      where: 'fullName = ?',
      whereArgs: [fullName],
    );

    if (existingUser.isNotEmpty) {
      return -1; // L'utilisateur existe déjà
    }

    // Création d'un nouvel utilisateur
    final id = await db.insert('user', {
      'fullName': fullName,
      'email': mail,
      'password': password,
    });
    print(id.toString());
    return id;
  }

  Future<bool> loginUser(String fullName, String password) async {
    final db = await database;

    // Recherche de l'utilisateur
    final result = await db.query(
      'user',
      where: 'email = ? AND password = ?',
      whereArgs: [fullName, password],
    );
    print(result);
    return result.isNotEmpty;
  }


  Future<void> insertData(Todo data) async {
    final db = await database;
    await db.insert('user', data.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

}