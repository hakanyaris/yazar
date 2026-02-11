import 'package:flutter/material.dart';
import 'package:yazar/model/kitap.dart';

class BolumlerSayfasi extends StatefulWidget {
  final Kitap _kitap;
  const BolumlerSayfasi(this._kitap, {super.key});

  @override
  State<BolumlerSayfasi> createState() => _BolumlerSayfasiState();
}

class _BolumlerSayfasiState extends State<BolumlerSayfasi> {
  @override
  Widget build(BuildContext context) {
    return Placeholder();
  }
}
