
# 🐣 Flutter’da SQLite Kullanımı: A’dan Z’ye Full Anlatım

---

### 1️⃣ SQLite Nedir?

* **SQLite**: Cebinde taşınabilen, dosya bazlı ilişkisel veritabanı.
* Flutter’da local veri tutmak için kullanılır.
* Karmaşık backend server kurmaya gerek yok, hızlı ve basit.

---

### 2️⃣ Flutter’da SQLite İçin Paket: `sqflite`

Pubspec.yaml’e ekle:

```yaml
dependencies:
  sqflite: ^2.2.0+3
  path_provider: ^2.0.15
  path: ^1.8.3
```

* `sqflite`: SQLite fonksiyonları
* `path_provider`: Telefon dosya sistemi yolunu bulmak için
* `path`: Dosya yollarını yönetmek için

---

### 3️⃣ SQLite Veritabanı Kurulumu

```dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('mydatabase.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final dbPath = join(documentsDirectory.path, filePath);

    return await openDatabase(dbPath, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT NOT NULL
      )
    ''');
  }

  Future<int> insertUser(Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.insert('users', row);
  }

  Future<List<Map<String, dynamic>>> queryAllUsers() async {
    final db = await instance.database;
    return await db.query('users');
  }

  Future<int> updateUser(Map<String, dynamic> row) async {
    final db = await instance.database;
    int id = row['id'];
    return await db.update('users', row, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteUser(int id) async {
    final db = await instance.database;
    return await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }
}
```

---

### 4️⃣ Kullanım Örneği

```dart
void main() async {
  final dbHelper = DatabaseHelper.instance;

  // Insert
  await dbHelper.insertUser({'name': 'Abdullah', 'email': 'abdullah@example.com'});

  // Query
  List<Map<String, dynamic>> users = await dbHelper.queryAllUsers();
  print(users);

  // Update
  await dbHelper.updateUser({'id': 1, 'name': 'Abdullah Yeni', 'email': 'abdullahyeni@example.com'});

  // Delete
  await dbHelper.deleteUser(1);
}
```

---

### 5️⃣ Detaylar ve Püf Noktaları

* Veritabanı dosyası cihazda `Documents` klasöründe saklanır.
* `id` otomatik artan primary key.
* `insertUser` fonksiyonu yeni satır ekler.
* `queryAllUsers` tüm satırları getirir.
* `updateUser` id’ye göre güncelleme yapar.
* `deleteUser` id’ye göre siler.

---

### 6️⃣ Neden SQLite?

* Offline uygulamalar için vazgeçilmez.
* Küçük ve orta çaplı veri depolama.
* Performans iyi, server gerektirmez.
* Flutter’a tam entegre.

---

### 7️⃣ Flutter’da UI ile Birlikte Kullanımı (Basit Örnek)

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final dbHelper = DatabaseHelper.instance;
  List<Map<String, dynamic>> users = [];

  @override
  void initState() {
    super.initState();
    _refreshUsers();
  }

  void _refreshUsers() async {
    final data = await dbHelper.queryAllUsers();
    setState(() {
      users = data;
    });
  }

  void _addUser() async {
    await dbHelper.insertUser({'name': 'Yeni Kanka', 'email': 'yenikanka@example.com'});
    _refreshUsers();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('SQLite Flutter Örnek')),
        body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            return ListTile(
              title: Text(user['name']),
              subtitle: Text(user['email']),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () async {
                  await dbHelper.deleteUser(user['id']);
                  _refreshUsers();
                },
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addUser,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
```

