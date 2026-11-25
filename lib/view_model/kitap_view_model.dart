import 'package:flutter/material.dart';
import 'package:yazar/model/kitap.dart';
import 'package:yazar/sabitler.dart';
import 'package:yazar/view/bolumler_sayfasi.dart';
import 'package:yazar/yerel_veri_tabani.dart';

class KitaplarViewModel {
  YerelVeriTabani _yerelVeriTabani = YerelVeriTabani();
  ScrollController _scrollController = ScrollController();
  List<Kitap> _kitaplar = [];
  int _secilenKategori = 0;
  List<int> _tumKategoriler = [-1];
  List<int> _seciliKitapIdleri =
      []; // checkBox ile seçilen kitapların id lerini tutacak.

  //kullanıcınmın Girdiği kitabı veritabanına ulaşıp veritababına kaydediyor.
  void _kitapEkle(BuildContext context) async {
    List<dynamic>? kitapAdiveKategori = await _pencereAc(context);
    if (kitapAdiveKategori != null && kitapAdiveKategori.length > 1) {
      String kitapAdi = kitapAdiveKategori[0];
      int kategori = kitapAdiveKategori[1];

      Kitap yeniKitap = Kitap(kitapAdi, DateTime.now(), kategori);
      int? kitapIdsi = await _yerelVeriTabani.createKitap(yeniKitap);
      print("Kitap id si : $kitapIdsi");
      if (kitapIdsi != null) {
        _kitaplar = []; //Readme.md 115 adımda açıkladık
        //veritabanına kitap eklendi fakat ekranda gösterilmedi.
        //setState(() {});
      }
    }
  }

  // Future<void> _tumKitaplariGetir() async {
  //   _kitaplar = await _yerelVeriTabani.readTumKitaplar(_secilenKategori);
  //   // for (var element in _kitaplar) {
  //   //   print(element.isim);
  //   // }
  // }
  // README.MD  108 MADDE
  Future<void> _ilkKitaplariGetir() async {
    // Readme.md 113 ve 114 madde açıklama var
    if (_kitaplar.isEmpty) {
      _kitaplar = await _yerelVeriTabani.readTumKitaplar(_secilenKategori, 0);
    }
  }

  Future<void> _sonrakiKitaplariGetir() async {
    int? sonKitapId = _kitaplar.last.id; //
    if (sonKitapId != null) {
      List<Kitap> sonrakiKitaplar = await _yerelVeriTabani.readTumKitaplar(
        _secilenKategori,
        sonKitapId,
      );
      _kitaplar.addAll(sonrakiKitaplar);
      //setState(() {});
    }
  }

  void _kitapGuncelle(BuildContext context, int index) async {
    Kitap kitap = _kitaplar[index];
    List<dynamic>? kitapAdiveKategori = await _pencereAc(
      context,
      mevcutIsim: kitap.isim,
      mevcutKategori: kitap.kategori,
    );
    if (kitapAdiveKategori != null && kitapAdiveKategori.length > 1) {
      String yeniKitapAdi = kitapAdiveKategori[0];
      int yeniKategori = kitapAdiveKategori[1];
      //mevcut kitap adı ve kategori adı yeni gelen ad ve kategoriyle aynı ise işlem yapma değişmişse işlem yapma performans güncellemesi
      if (kitap.isim != yeniKitapAdi || kitap.kategori != yeniKategori)
        kitap.isim = yeniKitapAdi;
      kitap.kategori = yeniKategori;
      int guncellenenSatirSayisi = await _yerelVeriTabani.updateKitap(kitap);
      if (guncellenenSatirSayisi > 0) {
        //Readme.md 115 adımda açıkladık
        //setState(() {});
      }
    }
  }

  void _kitapSil(int index) async {
    Kitap kitap = _kitaplar[index];

    int silinenSatirSayisi = await _yerelVeriTabani.deleteKitap(kitap);
    if (silinenSatirSayisi > 0) {
      _kitaplar = []; //Readme.md 115 adımda açıkladık
      //setState(() {});
    }
  }

  void _seciliKitapSil() async {
    int silinenSatirSayis = await _yerelVeriTabani.deleteKitaplar(
      _seciliKitapIdleri,
    );
  }

  void _bolumlerSayfasiniAc(BuildContext context, int index) {
    MaterialPageRoute sayfaYolu = MaterialPageRoute(
      builder: (context) {
        return BolumlerSayfasi(_kitaplar[index]);
      },
    );
    Navigator.push(context, sayfaYolu);
  }

  Future<List<dynamic>?> _pencereAc(
    BuildContext context, {
    String mevcutIsim = "",
    int mevcutKategori = 0,
  }) {
    TextEditingController isimController = TextEditingController(
      text: mevcutIsim,
    );
    return showDialog<List<dynamic>>(
      context: context,
      builder: (context) {
        // String? sonuc;
        int _secilenKategori = mevcutKategori;
        return AlertDialog(
          title: Text('Kitap Adını Giriniz'),
          content: StatefulBuilder(
            builder: (BuildContext context, void Function(void Function()) setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: isimController,
                    // onChanged: (value) {
                    //   sonuc = value;
                    // },
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Kategori"),
                      DropdownButton<int>(
                        value: _secilenKategori,
                        items: Sabitler.kategoriler.keys.map((kategoriId) {
                          return DropdownMenuItem<int>(
                            child: Text(Sabitler.kategoriler[kategoriId] ?? ""),
                            value: kategoriId,
                          );
                        }).toList(),
                        onChanged: (int? yeniDeger) {
                          setState(() {
                            if (yeniDeger != null)
                              // ÖNEMLİ setState yapsak bile sayfa yenilenmediğini görüyüroz çünkü AlertDialog builderi(contexi) ana sayfanın
                              //contexinden farklı ve Alert dielogun bulderini güncellemek için AletDialog içinde Content parametresinde
                              // StatefullBuilder() Kullanıyoruz
                              setState(() {
                                _secilenKategori = yeniDeger;
                              });
                          });
                        },
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('İptal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, [
                  isimController.text.trim(),
                  _secilenKategori,
                ]);
              },
              child: Text('Onayla'),
            ),
          ],
        );
      },
    );
  }

  void _kaydirmaKontrol() {
    //offset scrolcontrollerin mevcut kaydırma pozisyonu
    //_scrollController.position.maxScrollExtent   scrolcontrollerin kaydırılabileceği maxsimum pozisyon
    if (_scrollController.offset ==
        _scrollController.position.maxScrollExtent) {
      _sonrakiKitaplariGetir();
    }
  }
}
