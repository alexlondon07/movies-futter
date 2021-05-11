import 'package:flutter/material.dart';
import 'package:movies/src/pages/models/peliculas_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Pelicula> movies;

  MovieHorizontal({ @required this.movies });

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;

    return Container(
      height: _screenSize.height * 0.3,
      child: PageView(
        pageSnapping: false,
        controller: PageController(
          initialPage: 1,
          viewportFraction: 0.3
        ),
        children: _cards(context),
      )
    );
  }

  List<Widget> _cards (BuildContext context){
    return movies.map( (movie) {
      return Container(
        margin: EdgeInsets.only(right: 15.0),
          child: Column(
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: FadeInImage(
                  image: NetworkImage( movie.getPosterImg() ),
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  height: 160.0,
                ),
              ),
              Text(
                movie.title,
                overflow: TextOverflow.ellipsis, // Pone 3 ... cuando no cabe el texto,
                style: Theme.of(context).textTheme.caption
              )
            ],
        ),
      );
    }).toList();
  }


}
