class Ucan {
  void uc() => print('Uçuyorum!');
}

class Kus implements Ucan {
  @override
  void uc() => print('Kuş uçuyor');
}

class Ucak implements Ucan {
  @override
  void uc() => print('Uçak uçuyor');
}

void main() {
  Kus kus = Kus();
  kus.uc(); // Kuş uçuyor

  Ucan ucak = Ucak();
  ucak.uc(); // Uçak uçuyor

  // Aşağıdaki satır hata verecektir çünkü Ucan sınıfı Kus'un özelliklerine sahip değildir.
  // Kus kus2 = Ucan();
}
