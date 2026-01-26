import 'package:flutter/material.dart';
import 'package:yazar/view/kitaplar_sayfas%C4%B1.dart';

void main(){
runApp(AnaUygulama());
}
class AnaUygulama extends StatelessWidget {
  const AnaUygulama({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home:KitaplarSayfasi());
  }
}