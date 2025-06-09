

# 🌐 **API Entegrasyonu (Veri Çekme - HTTP ile GET/POST)**

Artık gerçek hayata adım atıyoruz. “Ben Flutter geliştiriyorum” demek, REST API’ye bağlanmadan OLMAZ!
Backend’le fıstık gibi iletişim kuracağız şimdi!

---

## 📦 http Paketi Kurulumu

İlk işimiz `http` paketini kurmak:

### `pubspec.yaml` içine:

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^0.14.0
```

Sonra şu komutla paketleri güncelle:

```bash
flutter pub get
```

---

## 🔍 Basit GET İsteği

Diyelim `https://jsonplaceholder.typicode.com/posts`’ten yazı listesi çekiyoruz.

```dart
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> fetchPosts() async {
  final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    print(data); // JSON dizisi olarak gelir
  } else {
    throw Exception('Veri alınamadı!');
  }
}
```

### Not:

* `jsonDecode()` Dart’ta JSON’ı **Map/List**'e çevirir.
* `http.get()` Future döndürür, o yüzden `await` kullanıyoruz.

---

## 💡 Model Oluşturma (Tip Güvenliği İçin)

Böyle kafasına göre JSON ile çalışılmaz. Model class yazılır!

### Örnek JSON:

```json
{
  "userId": 1,
  "id": 1,
  "title": "Merhaba dünya",
  "body": "Flutter ile API çekiyoruz!"
}
```

### Dart Model’i:

```dart
class Post {
  final int id;
  final String title;
  final String body;

  Post({
    required this.id,
    required this.title,
    required this.body,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}
```

---

## 🔄 Liste Halinde Gösterme (FutureBuilder + ListView)

Şimdi çektiğimiz datayı ekrana basalım!

```dart
Future<List<Post>> fetchPosts() async {
  final response = await http.get(
    Uri.parse('https://jsonplaceholder.typicode.com/posts'),
  );

  if (response.statusCode == 200) {
    final List<dynamic> jsonData = jsonDecode(response.body);
    return jsonData.map((e) => Post.fromJson(e)).toList();
  } else {
    throw Exception('Veri alınamadı');
  }
}
```

### Widget Kısmı:

```dart
class PostList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Post>>(
      future: fetchPosts(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final posts = snapshot.data!;
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return ListTile(
                title: Text(post.title),
                subtitle: Text(post.body),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Hata: ${snapshot.error}'));
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
```

---

## 🔐 POST İsteği (Veri Gönderme)

Veri ekleme işlemi için de `http.post()` kullanıyoruz.

```dart
Future<void> createPost() async {
  final response = await http.post(
    Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    headers: {"Content-type": "application/json; charset=UTF-8"},
    body: jsonEncode({
      "title": "Yeni Post",
      "body": "Abdullah yazıyor!",
      "userId": 1
    }),
  );

  if (response.statusCode == 201) {
    print("Başarıyla gönderildi");
    print(response.body);
  } else {
    throw Exception('Gönderim başarısız');
  }
}
```

---

## 📌 Kısaca

| İşlem               | Yöntem                       |
| ------------------- | ---------------------------- |
| Veri çek            | `http.get()`                 |
| Veri gönder         | `http.post()`                |
| JSON'u modele çevir | `factory Post.fromJson()`    |
| Widget’ta göster    | `FutureBuilder` + `ListView` |


