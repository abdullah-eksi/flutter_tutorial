void main(){
  Map<String, dynamic> kisi = {
  'isim': 'Ahmet',
  'yas': 25,
  'meslek': 'Developer'
};

print(kisi['isim']); // Ahmet
kisi['yas'] = 30;

print(kisi['yas']); // 30
print(kisi['meslek']); // Developer
print(kisi); // {isim: Ahmet, yas: 30, meslek: Developer
}