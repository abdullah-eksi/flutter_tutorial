void main() {
  // Koşullu ifadeler (if-else)
  // Kullanıcıdan alınan bir puana göre mesaj gösterme

  int puan = 55;

  if (puan >= 90 && puan <= 100) {
    print("Mükemmel");
  } else if (puan >= 70 && puan < 90) {
    print("İyi");
  } else if (puan >= 50 && puan < 70) {
    print("Orta");
  } else if (puan >= 0 && puan < 50) {
    print("Kaldın kanka");
  } else {
    print("Geçersiz puan");
  }
}
