

# ☠️ **1.11 – Null Safety & Tip Sistemi (Late, ?, !, required)**

> Kod çöker ama sen çökme! Null Safety seni çökmekten korur! 🛡️

---

## 💥 Nedir Bu Null Safety?

> Her değişkenin *null* olabileceği ya da olamayacağı **tip sisteminde belirtilir.**
> Dart: “Beni uyarmazsan, null’ı kafana atarım!” diyooor. 😈

---

## ✅ **Null Olmayan Değişken:**

```dart
String ad = 'Abdullah';
ad = 'Mehmet'; // olur
ad = null; // ❌ HATA VERİR!
```

---

## ❓ **Null Olabilen Değişken (nullable)**

```dart
String? soyad = null;
print(soyad); // null olur, ama çökmeyiz
```

> Sona `?` ekledin mi? Artık null olabilir. Kandırmacaya geldin 😎

---

## ❗ Null Assertion (!) – "Ben biliyorum abi boş değil!"

```dart
String? sehir = 'İstanbul';
print(sehir!); // İstanbul ✅
```

> Ama dikkat! Eğer `sehir = null` ise:

```
💣 BOOM → Unhandled Exception: Null check operator used on a null value.
```

---

## 🕓 `late` – “Sonradan tanımlanacak, ama boş olmayacak söz veriyorum!”

```dart
late String mesaj;
mesaj = 'Hoş geldin!';
print(mesaj); // Çalışır
```

> “Şimdi vermem ama sonra kesin vericem abi” diyen tipin özeti.

---

## 🔒 `required` – İsimli parametrede ‘bu boş geçilemez!’

```dart
void selamla({required String isim}) {
  print('Selam $isim');
}

selamla(isim: 'Zeynep'); // ✅
selamla(); // ❌ hata!
```

---

## ✅ Null Kontrolü Nasıl Yapılır?

```dart
String? ad;

if (ad != null) {
  print('Hoş geldin $ad');
} else {
  print('Ad girilmedi');
}
```

---

## 💡 Null Coalescing (??) – “Boşsa bunu ver!”

```dart
String? sehir;
print(sehir ?? 'Bilinmiyor'); // Bilinmiyor
```

---

## 🧪 Mini Görev – 7

🧪 1. `String? not` değişkeni oluştur ve null ata
🧪 2. `late int puan` tanımla → sonra 100 ata → yazdır
🧪 3. `String? mesaj = null` → yazdır ama `??` ile "Boş mesaj" gelsin
🧪 4. Fonksiyon yaz: `void bildir({required String mesaj})`
🧪 5. `String? isim;` → if ile null değilse yazdır, değilse "Anonim" de

