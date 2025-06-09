

## Basit Flutter Login & Register Uygulaması (SQLite ile)

---

### 1️⃣ Pubspec.yaml’e Şunları Ekle:

```yaml
dependencies:
  flutter:
    sdk: flutter
  sqflite: ^2.2.0+3
  path_provider: ^2.0.15
  path: ^1.8.3
```

---

### 2️⃣ Veritabanı Yardımcısı (DatabaseHelper) — Kullanıcıları tutacak

```dart
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();

  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('users.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    Directory dir = await getApplicationDocumentsDirectory();
    final path = join(dir.path, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE users(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      username TEXT NOT NULL UNIQUE,
      password TEXT NOT NULL
    )
    ''');
  }

  Future<int> registerUser(String username, String password) async {
    final db = await instance.database;
    return await db.insert('users', {'username': username, 'password': password});
  }

  Future<Map<String, dynamic>?> loginUser(String username, String password) async {
    final db = await instance.database;
    final res = await db.query('users',
        where: 'username = ? AND password = ?',
        whereArgs: [username, password]);
    if (res.isNotEmpty) return res.first;
    return null;
  }
}
```

---

### 3️⃣ Flutter Ana Ekran: Login & Register Arayüzü

```dart
import 'package:flutter/material.dart';
import 'database_helper.dart'; // yukarıdaki db kodu burada

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Basit Login Register',
      home: LoginRegisterScreen(),
    );
  }
}

class LoginRegisterScreen extends StatefulWidget {
  @override
  _LoginRegisterScreenState createState() => _LoginRegisterScreenState();
}

class _LoginRegisterScreenState extends State<LoginRegisterScreen> {
  final dbHelper = DatabaseHelper.instance;

  final _formKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLogin = true; // login mi register mı?

  String message = '';

  void toggleForm() {
    setState(() {
      isLogin = !isLogin;
      message = '';
      usernameController.clear();
      passwordController.clear();
    });
  }

  void submit() async {
    if (_formKey.currentState!.validate()) {
      String username = usernameController.text.trim();
      String password = passwordController.text.trim();

      if (isLogin) {
        // Login işlemi
        var user = await dbHelper.loginUser(username, password);
        if (user != null) {
          setState(() {
            message = 'Hoşgeldin, $username!';
          });
        } else {
          setState(() {
            message = 'Kullanıcı adı veya şifre yanlış!';
          });
        }
      } else {
        // Register işlemi
        try {
          await dbHelper.registerUser(username, password);
          setState(() {
            message = 'Kayıt başarılı, giriş yapabilirsin!';
            isLogin = true;
            usernameController.clear();
            passwordController.clear();
          });
        } catch (e) {
          setState(() {
            message = 'Bu kullanıcı adı zaten alınmış, başka seç!';
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isLogin ? 'Giriş Yap' : 'Kayıt Ol'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: usernameController,
                decoration: InputDecoration(labelText: 'Kullanıcı Adı'),
                validator: (val) => val == null || val.isEmpty ? 'Zorunlu alan' : null,
              ),
              SizedBox(height: 15),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Şifre'),
                obscureText: true,
                validator: (val) => val == null || val.isEmpty ? 'Zorunlu alan' : null,
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: submit,
                child: Text(isLogin ? 'Giriş Yap' : 'Kayıt Ol'),
              ),
              TextButton(
                onPressed: toggleForm,
                child: Text(isLogin
                    ? 'Hesabın yok mu? Kayıt ol'
                    : 'Zaten hesabın var mı? Giriş yap'),
              ),
              SizedBox(height: 20),
              Text(
                message,
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

---

### Özet:

* `DatabaseHelper` ile kullanıcıları SQLite’da tutuyoruz.
* `registerUser` fonksiyonu benzersiz kullanıcı adıyla kayıt yapıyor.
* `loginUser` kullanıcı adı & şifre eşleşirse kullanıcıyı döndürüyor.
* Basit validasyon var, boş bırakma, duplicate username engelleniyor.
* UI’de login/register arası geçiş yapılabiliyor.

---

### İsteğe Göre:

* Şifreyi **hash’lemek** için `crypto` paketi ekleyip güvenliği artırabilirsin.
* İleri seviye: Firebase Authentication’a geçiş yapabilirsin.
* LocalStorage veya SharedPreferences ile login durumunu saklayıp uygulama kapalıyken bile girişte tutabilirsin.
