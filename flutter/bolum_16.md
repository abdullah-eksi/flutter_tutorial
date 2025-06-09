
# 🚀 Flutter + Dart ile MongoDB Kullanımı (En Başından Uzaaaak Anlatım)

---

### 1️⃣ MongoDB Nedir Kanka?

MongoDB, NoSQL veritabanı, yani tablo-tablo ilişkisel değil, JSON-benzeri doküman formatında veri saklar. Esnek, hızlı, geliştiricinin can dostu!

---

### 2️⃣ Flutter’dan Direkt MongoDB’ye Bağlanılmaz!

Efsane spoiler: Flutter client (yani telefon, web app) doğrudan MongoDB’ye bağlanamaz! Çünkü:

* Güvenlik (DB’ye direkt bağlanmak hacker’lara davetiye çıkarır)
* MongoDB TCP/IP üzerinden çalışır, Flutter’da direct socket programlama zor ve önerilmez.

**Çözüm:** Flutter -> Backend API -> MongoDB

---

### 3️⃣ MongoDB Bağlantısı İçin Backend Gerek

Backend genellikle:

* Node.js (Express.js + Mongoose)
* Dart backend (Aqueduct veya Shelf)
* Python, Go, Java falan olabilir.

Senin Flutter frontend’in backend’e REST API ya da GraphQL ile bağlanacak.

---

### 4️⃣ MongoDB Backend Kurulumu (Örnek: Node.js + Express + Mongoose)

**Node.js kuruluysa:**

```bash
npm init -y
npm install express mongoose cors body-parser
```

`server.js`:

```js
const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');

const app = express();
app.use(cors());
app.use(express.json());

mongoose.connect('mongodb://localhost:27017/myflutterdb', {
  useNewUrlParser: true,
  useUnifiedTopology: true
}).then(() => console.log('MongoDB Bağlandı!'))
  .catch(err => console.log(err));

// Basit User Schema
const UserSchema = new mongoose.Schema({
  name: String,
  email: String
});

const User = mongoose.model('User', UserSchema);

// GET users
app.get('/users', async (req, res) => {
  const users = await User.find();
  res.json(users);
});

// POST user
app.post('/users', async (req, res) => {
  const newUser = new User(req.body);
  await newUser.save();
  res.json(newUser);
});

app.listen(3000, () => console.log('Server 3000 portunda çalışıyor'));
```

---

### 5️⃣ Flutter’dan API Çağrısı (Dart ile)

`pubspec.yaml`’e ekle:

```yaml
dependencies:
  http: ^0.13.5
```

Flutter kodu:

```dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class User {
  String name;
  String email;

  User({required this.name, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(name: json['name'], email: json['email']);
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
  };
}

// API’den kullanıcıları çek
Future<List<User>> fetchUsers() async {
  final response = await http.get(Uri.parse('http://localhost:3000/users'));
  if (response.statusCode == 200) {
    List jsonList = jsonDecode(response.body);
    return jsonList.map((json) => User.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load users');
  }
}

// API’ye kullanıcı ekle
Future<User> createUser(User user) async {
  final response = await http.post(
    Uri.parse('http://localhost:3000/users'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(user.toJson()),
  );

  if (response.statusCode == 200) {
    return User.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create user');
  }
}
```

---

### 6️⃣ Özet:

* **MongoDB’ye direkt Flutter’dan bağlanma, aman!**
* Backend yaz, Flutter API ile haberleşsin.
* Backend MongoDB’ye bağlanır, Flutter backend API’sini kullanır.

---

### 7️⃣ Eğer Serverless / Direkt MongoDB istersen?

* **MongoDB Realm** (eski adıyla Stitch) kullanabilirsin.
* Realm, Flutter SDK sağlıyor, backend yazmana gerek kalmadan bazı temel MongoDB işlemlerini yapabiliyorsun. Ama profesyonel projelerde backend şart!

---

## İstersen Realm ile örnek de açarız, ya da backend kodlarını detaylı yaparız, full paket!

Hadi kanka, MongoDB ile Flutter maceran nasıl olacak? Backend yazmak istersen Node.js’ten başlar, ya da direkt Realm deneyebiliriz. Ne dersin?
