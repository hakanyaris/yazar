import 'package:flutter/material.dart';
import 'package:yazar/model/kitap.dart';
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
    return ListView.builder(
      itemCount: _kitaplar.length,
      itemBuilder: _buildListItem,
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    return ListTile(
      leading: CircleAvatar(child: Text(_kitaplar[index].id.toString())),
      title: Text(_kitaplar[index].isim.toString()),
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
            icon: Icon(Icons.delete),
          ),
        ],
      ),
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
    String? kitapAdi = await _pencereAc(context);
    if (kitapAdi != null) {
      Kitap yeniKitap = Kitap(kitapAdi, DateTime.now());
      int? kitapIdsi = await _yerelVeriTabani.createKitap(yeniKitap);
      print("Kitap id si : $kitapIdsi");
      setState(() {});
    }
  }

  Future<void> _tumKitaplariGetir() async {
    _kitaplar = await _yerelVeriTabani.readTumKitaplar();
    for (var element in _kitaplar) {
      print(element.isim);
    }
  }

  void _kitapGuncelle(BuildContext context, int index) async {
    String? yeniKitap = await _pencereAc(context);
    if (yeniKitap != null) {
      Kitap kitap = _kitaplar[index];
      kitap.isim = yeniKitap;
      int SilinenSatirSayisi = await _yerelVeriTabani.updateKitap(kitap);
      if (SilinenSatirSayisi > 0) {
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
}

Future<String?> _pencereAc(BuildContext context) {
  return showDialog<String>(
    context: context,
    builder: (context) {
      String? sonuc;
      return AlertDialog(
        title: Text('Kitap Adını Giriniz'),
        content: TextField(
          onChanged: (value) {
            sonuc = value;
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
              Navigator.pop(context, sonuc);
            },
            child: Text('Onayla'),
          ),
        ],
      );
    },
  );
}
