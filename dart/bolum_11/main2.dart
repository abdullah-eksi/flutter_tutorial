void main() {
  // 🔹 Lambda fonksiyon: Kısa hali
  int carp(int a, int b) => a * b;
  print("Çarpım: ${carp(2, 3)}"); // 6

  // 🔸 Normal fonksiyon: Blok içinde yazım
  int topla(int a, int b) {
    return a + b;
  }
  print("Toplam: ${topla(5, 10)}"); // 15

  // 🔹 Lambda ile çıkarma
  int cikar(int a, int b) => a - b;
  print("Fark: ${cikar(10, 5)}"); // 5

  // 🔸 Normal fonksiyon: Bölme işlemi (sıfıra bölme kontrolü var)
  int bol(int a, int b) {
    if (b == 0) {
      throw Exception('Bölme işlemi için ikinci sayı sıfır olamaz!');
    }
    return a ~/ b; // Tam sayı bölme
  }

  try {
    print("Bölüm: ${bol(10, 2)}"); // 5
  } catch (e) {
    print(e);
  }

  // 🔹 Lambda fonksiyonla mod alma
  int mod(int a, int b) => a % b;
  print("Mod: ${mod(10, 3)}"); // 1

  // 🔹 Lambda fonksiyonla sayı karesi
  int kare(int x) => x * x;
  print("Karesi: ${kare(6)}"); // 36
}
