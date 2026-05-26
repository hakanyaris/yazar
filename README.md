# yazar

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
1=> main oluşturuyoruz
2=> view klasörü ve içinde kitaplar_sayfasi.dart oluşuruyoruz.   
3=> mainde MaterialApp(home: KitaplarSayfasi()); diyoruz.
4=> (Görsel olarak  kitaplarSayfasi ni tasarlıyoruz)Appbar ve FlotatingActionButton yerleştriyoruz.Buton onPress fonk _kitapEkle fonsinon tanımlıyoruz + simgesi veriyoruz
5=> KiapEkle fonksiyonunun içinde de _pencereAc() fonksinyonu tanımladık.
6=> pencereAc Fonsiyonn içine ShowDialog  onun da içine AlertDialog fonk. koyuyoruz Alert dilaloga kitap eklemek için bir TextField()  ,iki tane buton koyuyoruz(TextButton) koyuyoruz iptal ve kaydet 
7=> Texfiel yazılan değeri String sonuc  değerine eşitlerdik sonuc değerini  return showDilog<String> diyerek  ve  Future<String>?>  _pencereAc  diyerek fonsiyoru geriye String döndürür şekilde ayarladık.
8=> Kitap Sınıfı oluşturuyoruz Model klasörü açıp içine Kitap sınıfı oluşturuyoruz. int? id,Sring isim ,DateTime olusturulmaTarihi ve kurucu metot;
9=>_kitapEkle() FONKSİYONUN içine  yeni birkitap nesenesi oluştrup _pencereAc dan gelen sonuc (kitap adı) değerini kitap adı olarak veriyoruz.

