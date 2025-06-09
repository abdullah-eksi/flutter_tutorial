
## 📦 FLUTTER + REST API (CRUD OPERASYONLARI)

Verileri sadece çekmekle kalmayacağız;
**O veriyi güncelleyeceğiz, sileceğiz, ekleyeceğiz, detay sayfasına geçeceğiz!**
Burası artık “Kardeşim ben App yapıyorum ya!” seviyesi 💪

---

## 🔄 CRUD: Ne Demekti?

CRUD → Create - Read - Update - Delete
Yani:

* ➕ **Create (POST)** → Yeni veri ekle
* 📖 **Read (GET)** → Veri çek
* ✏️ **Update (PUT/PATCH)** → Var olanı güncelle
* 🗑️ **Delete (DELETE)** → Sil gitsin

---

## 🧪 Örnek API:

`https://jsonplaceholder.typicode.com/posts`

---

## 🔧 UPDATE (PUT) — VERİ GÜNCELLEME

```dart
Future<void> updatePost(Post post) async {
  final response = await http.put(
    Uri.parse('https://jsonplaceholder.typicode.com/posts/${post.id}'),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "title": post.title + " (güncellendi)",
      "body": post.body + " (düzenlendi)",
      "userId": post.userId
    }),
  );

  if (response.statusCode == 200) {
    print("Güncelleme başarılı: ${response.body}");
  } else {
    throw Exception("Güncelleme başarısız oldu");
  }
}
```

> Not: JSONPlaceholder sahte bir API olduğu için backend'de değişiklik yapmaz ama senin Flutter kodunu test etmek için **birebir aynı mantığı verir.**

---

## 🧨 DELETE — VERİ SİLME

```dart
Future<void> deletePost(int id) async {
  final response = await http.delete(
    Uri.parse('https://jsonplaceholder.typicode.com/posts/$id'),
  );

  if (response.statusCode == 200) {
    print("Post silindi!");
  } else {
    throw Exception("Silinemedi 😓");
  }
}
```

---

## ➕ CREATE — YENİ VERİ EKLE (POST)

```dart
Future<void> createPost(Post post) async {
  final response = await http.post(
    Uri.parse('https://jsonplaceholder.typicode.com/posts'),
    headers: {"Content-Type": "application/json"},
    body: jsonEncode({
      "title": post.title,
      "body": post.body,
      "userId": post.userId
    }),
  );

  if (response.statusCode == 201) {
    print("Yeni post oluşturuldu: ${response.body}");
  } else {
    throw Exception("Post eklenemedi 😓");
  }
}
```

---

## 🛠️ Arayüzden Butonlarla Kontrol Etme (Silme, Güncelleme)

```dart
ListTile(
  title: Text(post.title),
  subtitle: Text(post.body),
  trailing: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      IconButton(
        icon: Icon(Icons.edit),
        onPressed: () {
          updatePost(post);
        },
      ),
      IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          deletePost(post.id);
        },
      ),
    ],
  ),
),
```

---

## 🚀 CRUD Nedir, Ne Değildir?

| İşlem  | HTTP Yöntemi | Kullanım   | Backend’e Etkisi     |
| ------ | ------------ | ---------- | -------------------- |
| Read   | GET          | Veri çekme | Sadece gösterim      |
| Create | POST         | Yeni ekle  | Veri oluşturur       |
| Update | PUT/PATCH    | Güncelle   | Var olanı değiştirir |
| Delete | DELETE       | Sil        | Veriyi kaldırır      |

---
