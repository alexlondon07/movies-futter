import 'package:flutter/material.dart';
import 'package:movies/src/pages/models/peliculas_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Pelicula> movies;
  final Function nextPage;

  MovieHorizontal({ @required this.movies, @required this.nextPage });

  final _pageController = PageController(
    initialPage: 1,
    viewportFraction: 0.3
  );

  @override
  Widget build(BuildContext context) {

    final _screenSize = MediaQuery.of(context).size;


    _pageController.addListener(() {
        if( _pageController.position.pixels >= _pageController.position.maxScrollExtent - 200){
          nextPage();
        }
    });

    return Container(
      height: _screenSize.height * 0.3,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        //children: _cards(context),
        itemCount: movies.length,
        itemBuilder: ( context, i) => _card( context, movies[i] ),
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

  Widget _card(BuildContext context, Pelicula movie){
    final card = Container(
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

    return GestureDetector(
      child: card,
      onTap: () {
        Navigator.pushNamed(context, 'detail', arguments: movie);
      }
    );

  }


}
