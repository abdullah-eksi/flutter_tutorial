

## 🧠 **1.7 – Koşullar (if-else), switch-case, kullanıcı mantığı**

> Kodun zekâ kısmı. Bu olmadan uygulama yazılmaz. Burası olayların kalbi. ❤️

---

## 🧩 **if - else Yapısı**

```dart
int yas = 17;

if (yas >= 18) {
  print('Reşitsin, seçimde oy kullanabilirsin.');
} else {
  print('Kusura bakma kanka, daha küçükmüşsün.');
}
```

---

### ➕ `else if` Kullanımı

```dart
int not = 75;

if (not >= 90) {
  print('AA – Helal be!');
} else if (not >= 80) {
  print('BA – Güzel not');
} else if (not >= 70) {
  print('BB – İdare eder');
} else {
  print('Kanka bu nedir ya 😬');
}
```

---

## 🪄 **Ternary Operatör (Kısa if-else)**

```dart
int yas = 20;
String mesaj = (yas >= 18) ? 'Giriş yapıldı' : 'Yaş tutmuyor';
print(mesaj);
```

---

## 🔁 **switch - case Kullanımı**

```dart
String gun = 'pazartesi';

switch (gun) {
  case 'pazartesi':
    print('Kod haftası başladı kanka!');
    break;
  case 'cumartesi':
    print('Yatış moduna geçildi');
    break;
  default:
    print('Normal bir gün...');
}
```

---

## 🧪 **Mini Görev – 3**

Bir değişken tanımla: `puan = 55`
Bu puana göre şu kuralları yaz:

* 90-100: "Mükemmel"
* 70-89: "İyi"
* 50-69: "Orta"
* 0-49: "Kaldın kanka"

Ternary ile veya `if-else` ile fark etmez. Hadi döktür!

```dart
void main() {
  int puan = 55;

  // koşullar buraya
}
```

---

## ⚡ Bonus: Kullanıcıdan Değer Alma (CLI İçin)

Eğer Dart CLI (terminal) için çalışıyorsak:

```dart
import 'dart:io';

void main() {
  print('Adını yaz:');
  String? ad = stdin.readLineSync();

  print('Selam $ad!');
}
```

