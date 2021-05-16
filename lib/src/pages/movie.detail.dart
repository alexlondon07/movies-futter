import 'package:flutter/material.dart';
import 'package:movies/src/pages/models/peliculas_model.dart';

class MovieDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final Pelicula movie =  ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body:  Center(child:  Center( child: Text(movie.title) )
    )
    );
  }
}