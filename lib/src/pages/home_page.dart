import 'package:flutter/material.dart';
import 'package:movies/src/providers/peliculas_provider.dart';
import 'package:movies/src/widgets/card_swiper_widget.dart';
import 'package:movies/src/widgets/movies_horizotal.dart';

class HomePage extends StatelessWidget {
  final moviesProvider = new PeliculasProvider();


  @override
  Widget build(BuildContext context) {

    moviesProvider.getPopulars();

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
            Container(
              child: Text('Populares', style: Theme.of(context).textTheme.subtitle1),
              padding: EdgeInsets.only(left: 20.0)
            ),
            SizedBox(height: 5.0),
            StreamBuilder(
              stream: moviesProvider.popularsStream,
              builder: (BuildContext context, AsyncSnapshot<List> snapshot){
                if(snapshot.hasData){
                  return  MovieHorizontal(movies: snapshot.data, nextPage: moviesProvider.getPopulars );
                }else{
                  return Container(child: Center(child: CircularProgressIndicator()));
              }
            },
          )
        ]
      )
    );
  }

}