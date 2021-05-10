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
      body: Container(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround, // Para que tenga espacio entre los elementos
          children: <Widget>[
            _swiperTarjetas(),
            _footer(context)
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

  //  Listado de las peliculas populares
  Widget _footer(BuildContext context){
    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Text('Populares', style: Theme.of(context).textTheme.subtitle1),
            FutureBuilder(
              future: moviesProvider.getPopulars(),
              builder: (BuildContext context, AsyncSnapshot<List> snapshot){
                if(snapshot.hasData){
                return  CardSwiper(peliculas: snapshot.data);
                }else{
                return Container(
                    child: Center(child: CircularProgressIndicator())
                );
              }
            },
          )
        ]
      )
    );
  }

}