import 'package:flutter/material.dart';
import 'package:yazar/model/kitap.dart';
import 'package:yazar/sabitler.dart';
import 'package:yazar/view/bolumler_sayfasi.dart';
import 'package:yazar/yerel_veri_tabani.dart';

class KitaplarSayfasi extends StatefulWidget {
  @override
  State<KitaplarSayfasi> createState() => _KitaplarSayfasiState();
}

class _KitaplarSayfasiState extends State<KitaplarSayfasi> {
  YerelVeriTabani _yerelVeriTabani = YerelVeriTabani();

  List<Kitap> _kitaplar = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: buildBody(),

      floatingActionButton: _buildKitapEkleFab(context),
    );
  }

  //---------------------------------------------------------------------------
  AppBar appBar() {
    return AppBar(title: Text('KİTAPLAR SAYFASI'));
  }

  Widget buildBody() {
    // init Stata kullanmıyoruz FutureBuilder Kullanıyoruz.
    // FuturBuilder ile  //future içindeki fonsiyon çalışır daha sora // buildere yazılan fonlsiyon çalışır. yani
    // _tumKitaplariGetir fonksiyonu ile kitapları sqflite den çeker sonra bulder: deki  _buildListView ile ekranı çizer.
    return FutureBuilder(future: _tumKitaplariGetir(), builder: _buildListView);
  }

  Widget _buildListView(BuildContext context, AsyncSnapshot<void> snapShot) {
    // Veri yükleniyor mu kontrolü
    if (snapShot.connectionState == ConnectionState.waiting) {
      return Center(child: CircularProgressIndicator());
    }

    if (_kitaplar.isEmpty) {
      return Center(child: Text("Henüz kitap eklenmemiş."));
    }

    return ListView.builder(
      itemCount: _kitaplar.length,
      itemBuilder: _buildListItem,
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    return ListTile(
      leading: CircleAvatar(child: Text(_kitaplar[index].id.toString())),
      title: Text(_kitaplar[index].isim.toString()),
      subtitle: Text(Sabitler.kategoriler[_kitaplar[index].kategori] ?? " "),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.edit_outlined),
            onPressed: () {
              _kitapGuncelle(context, index);
            },
          ),
          IconButton(
            onPressed: () {
              _kitapSil(index);
            },
            icon: Icon(Icons.delete, color: Colors.black),
          ),
        ],
      ),
      onTap: () {
        _bolumlerSayfasiniAc(context, index);
      },
    );
  }

  Widget _buildKitapEkleFab(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        _kitapEkle(context);
      },
    );
  }

  void _kitapEkle(BuildContext context) async {
    List<dynamic>? kitapAdiveKategori = await _pencereAc(context);
    if (kitapAdiveKategori != null && kitapAdiveKategori.length > 1) {
      String kitapAdi = kitapAdiveKategori[0];
      int kategori = kitapAdiveKategori[1];

      Kitap yeniKitap = Kitap(kitapAdi, DateTime.now(), kategori);
      int? kitapIdsi = await _yerelVeriTabani.createKitap(yeniKitap);
      print("Kitap id si : $kitapIdsi");
      if (kitapIdsi != null) {
        setState(() {});
      }
    }
  }

  Future<void> _tumKitaplariGetir() async {
    _kitaplar = await _yerelVeriTabani.readTumKitaplar();
    for (var element in _kitaplar) {
      print(element.isim);
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
        setState(() {});
      }
    }
  }

  void _kitapSil(int index) async {
    Kitap kitap = _kitaplar[index];

    int silinenSatirSayisi = await _yerelVeriTabani.deleteKitap(kitap);
    if (silinenSatirSayisi > 0) {
      setState(() {});
    }
  }

  void _bolumlerSayfasiniAc(BuildContext context, int index) {
    MaterialPageRoute sayfaYolu = MaterialPageRoute(
      builder: (context) {
        return BolumlerSayfasi(_kitaplar[index]);
      },
    );
    Navigator.push(context, sayfaYolu);
  }

  Future<List<dynamic>?>  _pencereAc(
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
}
