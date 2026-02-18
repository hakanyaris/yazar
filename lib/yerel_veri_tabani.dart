import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:yazar/model/bolum.dart';
import 'package:yazar/model/kitap.dart';

class YerelVeriTabani {
  //singletion
  YerelVeriTabani._privateConstructur();

  static final YerelVeriTabani _nesne = YerelVeriTabani._privateConstructur();

  // factory constructur bir nesne ürettiği nesneyi düzenleyip geri döndürür.
  // Bir YerelVeriTabani nesnesi mainde oluşturulduğunda ilk aşağdaki  factory YerelVeriTabani  constructur çağrılır.
  //o da geriye _nesne döndürü ,önceden bir nesne oluşturulmadıysa YerelVeriTabani._privateConstructur(); nesnesi oluşturulur
  //ve geriye döndürülür.Fakat ikinci çağrılmada _nesne önecden oluturulduğu için ve final olduğu için önceki (ilk)nesne verilir ve değiştirilemez
  factory YerelVeriTabani() {
    return _nesne;
  }
  Database? _veriTabani;
  String _kitaplarTabloAdi = "kitaplar";
  String _idKitaplar = "id";
  String _isimKitaplar = "isim";
  String _olusturulmaTarihiKitaplar = "olusturulmaTarihi";
  String _kategoriKitaplar = "kategori";

  String _bolumlerTabloAdi = "bolumler";
  String _idBolumler = "id";
  String _kitapIdBolumler = "kitapId";
  String _baslikBolumler = "baslik";
  String _icerikBolumler = "icerik";
  String _olusturulmaTarihiBolumler = "olusturulmaTarihi";

  Future<Database?> _veriTabaniGetir() async {
    if (_veriTabani == null) {
      String dosyaYolu = await getDatabasesPath();
      String veriTabaniYolu = join(dosyaYolu, "yazar.db");

      _veriTabani = await openDatabase(
        veriTabaniYolu,
        //versionu değiştirince onUpgrade çalışır
        version: 3,
        //onCreate fonksiyonu veri tabanı oluştuğunda çalışan fonsiyondur.Bu yüzden biz tabloları da burada oluşturuyoruz.
        onCreate: _tabloOlustur,
        //Veritabanımız ilk kez olşturulduğunda id isim olusturulmaTarih otomatik olarak sqflite tablo olarak oluşur.
        //Fakat tablomuza ileride yeni bir satır (mesemla kategori sonradan ekledik)eklemek isteiğimizde tablo öncelden olşturulduğu için
        //direk bunu yapmak bunun için onUpgrade kullanılıyoruz.
        onUpgrade: _tabloGuncelle,
      );
    }
    return _veriTabani;
  }

  ///onCreate için oluşturulan fonsiyon
  Future<void> _tabloOlustur(Database db, int versiyon) async {
    await db.execute("""
CREATE TABLE $_kitaplarTabloAdi (
	$_idKitaplar	INTEGER NOT NULL UNIQUE PRIMARY KEY AUTOINCREMENT,
	$_isimKitaplar	TEXT NOT NULL,
	$_olusturulmaTarihiKitaplar 	INTEGER,
  $_kategoriKitaplar INTEGER DEFAULT 0
);
""");
    await db.execute("""
CREATE TABLE $_bolumlerTabloAdi (
	$_idBolumler	INTEGER NOT NULL UNIQUE PRIMARY KEY AUTOINCREMENT,
	$_kitapIdBolumler	INTEGER NOT NULL,
  $_baslikBolumler TEXT NOT NULL,
  $_icerikBolumler  TEXT ,
	$_olusturulmaTarihiBolumler TEXT DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY("$_kitapIdBolumler") REFERENCES "$_kitaplarTabloAdi" ("$_idKitaplar") ON UPDATE CASCADE ON DELETE CASCADE
);
""");
  } //

  Future<void> _tabloGuncelle(
    Database db,
    int eskiVersion, //mesela 2
    int yeniVersion, //mesela 5
  ) async {
    //Bu liste sayesinde version güncellemelerinde eksi güncelleme iki defa çalışmayacak ve yeni
    // güncellemeler yeni version no girmemizle tabloya eklenecek
    List<String> guncellemeKomutlari = [
      "ALTER TABLE $_kitaplarTabloAdi ADD COLUMN $_kategoriKitaplar INTEGER DEFAULT 0",
      "ALTER TABLE $_kitaplarTabloAdi ADD COLUMN test INTEGER DEFAULT 0",
      //yeni komutları alta ekliyoruz
    ];

    for (int i = eskiVersion - 1; i < yeniVersion - 1; i++) {
      await db.execute(guncellemeKomutlari[i]);
    }
    //kategori satırını kodumuza ekledik fakat cihazdaki veri tabanına eklenmesi için bu kodu yazdık ve
    //ve openDatabase version: 2 yaptık (versionu değiiştirmezsek tabloda güncelleme olmaz)
    //komut yukarıda güncellendi for içinde
    // await db.execute(
    //   "ALTER TABLE $_kitaplarTabloAdi ADD COLUMN $_kategoriKitaplar INTEGER DEFAULT 0",
    // );
  }

  /// kitabı veritabanına ekleme fonksiyonu  bu adımdan sonra KitaplarSayfasi gidip orada  YerelVeriTabani nesnesi oluşturuyoruz
  Future<int?> createKitap(Kitap kitap) async {
    Database? db = await _veriTabaniGetir();
    if (db != null) {
      return await db.insert(_kitaplarTabloAdi, kitap.toMap());
    } else
      return -1;
  }

  Future<List<Kitap>> readTumKitaplar() async {
    Database? db = await _veriTabaniGetir();
    List<Kitap> kitaplar = [];
    if (db != null) {
      List<Map<String, dynamic>> kitaplarMap = await db.query(
        _kitaplarTabloAdi,
      );
      for (Map<String, dynamic> m in kitaplarMap) {
        Kitap k = Kitap.fromMap(m);
        kitaplar.add(k);
      }
    }
    return kitaplar;
  }

  Future<int> updateKitap(Kitap kitap) async {
    Database? db = await _veriTabaniGetir();
    if (db != null) {
      return await db.update(
        _kitaplarTabloAdi,
        kitap.toMap(),
        where: "$_idKitaplar = ?",
        whereArgs: [kitap.id],
      );
    } else {
      return 0;
    }
  }

  Future<int> deleteKitap(Kitap kitap) async {
    Database? db = await _veriTabaniGetir();
    if (db != null) {
      return await db.delete(
        _kitaplarTabloAdi,
        where: "$_idKitaplar = ?",
        whereArgs: [kitap.id],
      );
    } else {
      return 0;
    }
  }

  Future<int?> createBolum(Bolum bolum) async {
    Database? db = await _veriTabaniGetir();
    if (db != null) {
      return await db.insert(_bolumlerTabloAdi, bolum.toMap());
    } else
      return -1;
  }

  // Bolumler kısmında tüm bölümleri değil belli bir kitaba ait bölümleri veritabanından alacağız
  Future<List<Bolum>> readTumBolumler(int kitapId) async {
    Database? db = await _veriTabaniGetir();
    List<Bolum> bolumler = [];
    if (db != null) {
      List<Map<String, dynamic>> bolumlerMap = await db.query(
        _bolumlerTabloAdi,
        where: "$_kitapIdBolumler = ?",
        whereArgs: [kitapId],
      );
      for (Map<String, dynamic> m in bolumlerMap) {
        Bolum b = Bolum.fromMap(m);
        bolumler.add(b);
      }
    }
    return bolumler;
  }

  Future<int> updateBolum(Bolum bolum) async {
    Database? db = await _veriTabaniGetir();
    if (db != null) {
      return await db.update(
        _bolumlerTabloAdi,
        bolum.toMap(),
        where: "$_idBolumler = ?",
        whereArgs: [bolum.id],
      );
    } else {
      return 0;
    }
  }

  Future<int> deleteBolum(Bolum bolum) async {
    Database? db = await _veriTabaniGetir();
    if (db != null) {
      return await db.delete(
        _bolumlerTabloAdi,
        where: "$_idBolumler = ?",
        whereArgs: [bolum.id],
      );
    } else {
      return 0;
    }
  }
}


/* CREATE TABLE "kitaplar" (
	"id"	INTEGER NOT NULL UNIQUE PRIMARY KEY AUTOINCREMENT,
	"isim"	TEXT NOT NULL,
	"yazar"	TEXT,
	"sayfaSayisi"	INTEGER,
	"ilkBasimYili"	INTEGER
);
*/