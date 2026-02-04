import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
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

  Future<Database?> _veriTabaniGetir() async {
    if (_veriTabani == null) {
      String dosyaYolu = await getDatabasesPath();
      String veriTabaniYolu = join(dosyaYolu, "yazar.db");

      _veriTabani = await openDatabase(
        veriTabaniYolu,
        version: 1,
        //onCreate fonksiyonu veri tabanı oluştuğunda çalışan fonsiyondur.Bu yüzden biz tabloları da burada oluşturuyoruz.
        onCreate: _tabloOlustur,
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
	$_olusturulmaTarihiKitaplar 	INTEGER
);
""");
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
}


/* CREATE TABLE "kitaplar" (
	"id"	INTEGER NOT NULL UNIQUE PRIMARY KEY AUTOINCREMENT,
	"isim"	TEXT NOT NULL,
	"yazar"	TEXT,
	"sayfaSayisi"	INTEGER,
	"ilkBasimYili"	INTEGER
);
*/