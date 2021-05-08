import 'package:flutter/material.dart';
import 'package:movies/src/providers/peliculas_provider.dart';
import 'package:movies/src/widgets/card_swiper_widget.dart';

class HomePage extends StatelessWidget {
  final moviesProvider = new PeliculasProvider();

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

    return FutureBuilder(
      future: moviesProvider.getNowPlaying(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if(snapshot.hasData){
          return  CardSwiper(peliculas: snapshot.data);
        }else{
          return Container(
              child: Center(child: CircularProgressIndicator())
            );
        }
      },
    );
  }



}