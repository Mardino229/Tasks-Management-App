
class User {
  final int id;
  final String email;
  final String fullName;
  final String password;


  const User({
    required this.id,
    required this.fullName,
    required this.password,
    required this.email,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? 0,
      fullName: map['fullName'] ?? '',
      password: map['email'] ?? '',
      email: map['password'] ?? '',
    );
  }

  Map<String, Object> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'password': password,
    };
  }
}

class Todo {
  final int id;
  final String name;
  final String description;
  final String statut;


  const Todo({
    required this.id,
    required this.name,
    required this.description,
    required this.statut
  });

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      statut: map['statut'] ?? '',
    );
  }

  Map<String, Object> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'statut': statut,
    };
  }
}

