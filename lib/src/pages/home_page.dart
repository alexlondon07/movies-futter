import 'package:flutter/material.dart';
import 'package:movies/src/providers/peliculas_provider.dart';
import 'package:movies/src/widgets/card_swiper_widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Peliculas en cines.'),
        backgroundColor: Colors.indigoAccent,
        actions: [
            IconButton(icon: Icon(Icons.search), onPressed: () {})
        ],
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            _swiperTarjetas()
          ],
        )
      )
    );
  }

  Widget _swiperTarjetas(){
    final moviesProvider = new PeliculasProvider();
    moviesProvider.getNowPlaying();
    return  CardSwiper(
      peliculas: [1,2,3,4,5],
      );
  }
}