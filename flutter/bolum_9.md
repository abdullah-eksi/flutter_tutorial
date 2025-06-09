
## 🔥 FLUTTER'DA GET REQUEST İLE VERİ ÇEKME

---

### 🎯 Hedefimiz:

🔹 `https://jsonplaceholder.typicode.com/posts` gibi sahte bir API'den veri çekip
🔹 Flutter app içinde bir liste (ListView) olarak göstermek.

---

## 1️⃣. http Paketini Hatırla

Projende hâlâ varsa tekrar eklemene gerek yok:

```yaml
dependencies:
  http: ^0.13.6
```

---

## 2️⃣. Veri Modeli Oluştur (JSON → Dart Nesnesi)

Çünkü backend bize JSON yolluyor, Dart ise Class’la çalışmayı sever. Bu yüzden:

### 🧱 JSON Örneği:

```json
{
  "userId": 1,
  "id": 1,
  "title": "Flutter çok yakışıklı",
  "body": "Backend'den geldi bu veri."
}
```

---

### 🔨 Dart Modeli:

```dart
class Post {
  final int userId;
  final int id;
  final String title;
  final String body;

  Post({required this.userId, required this.id, required this.title, required this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json["userId"],
      id: json["id"],
      title: json["title"],
      body: json["body"],
    );
  }
}
```

---

## 3️⃣. API’den Veri Çekme Fonksiyonu

```dart
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Post>> fetchPosts() async {
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

  if (response.statusCode == 200) {
    List<dynamic> jsonData = jsonDecode(response.body);
    return jsonData.map((e) => Post.fromJson(e)).toList();
  } else {
    throw Exception("Veri çekilemedi 😔");
  }
}
```

---

## 4️⃣. Arayüzde Gösterelim (FutureBuilder + ListView)

```dart
class PostList extends StatefulWidget {
  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  late Future<List<Post>> _futurePosts;

  @override
  void initState() {
    super.initState();
    _futurePosts = fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Postlar')),
      body: FutureBuilder<List<Post>>(
        future: _futurePosts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Hata: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Post bulunamadı"));
          } else {
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
          }
        },
      ),
    );
  }
}
```

