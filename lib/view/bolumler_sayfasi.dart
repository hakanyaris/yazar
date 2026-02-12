import 'package:flutter/material.dart';
import 'package:yazar/model/bolum.dart';
import 'package:yazar/model/kitap.dart';
import 'package:yazar/view/bolum_detay_sayfasi.dart';
import 'package:yazar/yerel_veri_tabani.dart';

class BolumlerSayfasi extends StatefulWidget {
  final Kitap _kitap;
  const BolumlerSayfasi(this._kitap, {super.key});

  @override
  State<BolumlerSayfasi> createState() => _BolumlerSayfasiState();
}

class _BolumlerSayfasiState extends State<BolumlerSayfasi> {
  YerelVeriTabani _yerelVeriTabani = YerelVeriTabani();

  List<Bolum> _bolumler = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: buildBody(),

      floatingActionButton: _buildBolumEkleFab(context),
    );
  }

  //---------------------------------------------------------------------------
  AppBar appBar() {
    return AppBar(title: Text(widget._kitap.isim));
  }

  Widget buildBody() {
    // init Stata kullanmıyoruz FutureBuilder Kullanıyoruz.
    // FuturBuilder ile  //future içindeki fonsiyon çalışır daha sora // buildere yazılan fonlsiyon çalışır. yani
    // _tumBolumlariGetir fonksiyonu ile Bolumları sqflite den çeker sonra bulder: deki  _buildListView ile ekranı çizer.
    return FutureBuilder(future: _tumBolumleriGetir(), builder: _buildListView);
  }

  Widget _buildListView(BuildContext context, AsyncSnapshot<void> snapShot) {
    // Veri yükleniyor mu kontrolü
    if (snapShot.connectionState == ConnectionState.waiting) {
      return Center(child: CircularProgressIndicator());
    }

    if (_bolumler.isEmpty) {
      return Center(child: Text("Henüz Bolum eklenmemiş."));
    }

    return ListView.builder(
      itemCount: _bolumler.length,
      itemBuilder: _buildListItem,
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    return ListTile(
      leading: CircleAvatar(child: Text(_bolumler[index].id.toString())),
      title: Text(_bolumler[index].baslik.toString()),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.edit_outlined),
            onPressed: () {
              _BolumGuncelle(context, index);
            },
          ),
          IconButton(
            onPressed: () {
              _BolumSil(index);
            },
            icon: Icon(Icons.delete, color: Colors.black),
          ),
        ],
      ),
      onTap: () {
        _bolumDetaySayfasiniAc(context, index);
      },
    );
  }

  Widget _buildBolumEkleFab(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        _BolumEkle(context);
      },
    );
  }

  void _BolumEkle(BuildContext context) async {
    String? BolumBasligi = await _pencereAc(context);
    int? kitapId = widget._kitap.id;
    if (BolumBasligi != null && kitapId != null) {
      Bolum yeniBolum = Bolum(kitapId, BolumBasligi);
      int? BolumIdsi = await _yerelVeriTabani.createBolum(yeniBolum);
      print("Bolum id si : $BolumIdsi");
      if (BolumIdsi != null) {
        setState(() {});
      }
    }
  }

  Future<void> _tumBolumleriGetir() async {
    int? kitapId = widget._kitap.id;
    if (kitapId != null) {
      _bolumler = await _yerelVeriTabani.readTumBolumler(kitapId);
    }

    for (var element in _bolumler) {
      print(element.baslik);
    }
  }

  void _BolumGuncelle(BuildContext context, int index) async {
    String? yeniBolumBasligi = await _pencereAc(context);
    if (yeniBolumBasligi != null) {
      Bolum bolum = _bolumler[index];
      bolum.baslik = yeniBolumBasligi;
      int guncellenenSatirSayisi = await _yerelVeriTabani.updateBolum(bolum);
      if (guncellenenSatirSayisi > 0) {
        setState(() {});
      }
    }
  }

  void _BolumSil(int index) async {
    Bolum bolum = _bolumler[index];

    int silinenSatirSayisi = await _yerelVeriTabani.deleteBolum(bolum);
    if (silinenSatirSayisi > 0) {
      setState(() {});
    }
  }

  Future<String?> _pencereAc(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (context) {
        String? sonuc;
        return AlertDialog(
          title: Text('Bölüm Adını Giriniz'),
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

  void _bolumDetaySayfasiniAc(BuildContext context, int index) {
    MaterialPageRoute sayfaYolu = MaterialPageRoute(
      builder: (context) {
        return BolumDetaySayfasi(_bolumler[index]);
      },
    );
    Navigator.push(context, sayfaYolu);
  }
}
