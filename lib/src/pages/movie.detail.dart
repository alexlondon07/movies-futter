import 'package:flutter/material.dart';
import 'package:movies/src/pages/models/peliculas_model.dart';

class MovieDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final Pelicula movie =  ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body:  CustomScrollView(
        slivers: <Widget>[
          _createAppBar(movie),
          SliverList(delegate: SliverChildListDelegate(
            [
              SizedBox( height: 10.0),
              _posterTitle(movie, context),
              _description( movie ),
            ]
          ))
        ],
      )
    );
  }

  Widget _createAppBar (Pelicula movie) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          movie.title,
          style: TextStyle(color: Colors.white, fontSize: 16.0 )
        ),
        background: FadeInImage(
          image: NetworkImage( movie.getBackgroundImgImg() ),
          placeholder: AssetImage('assets/img/loading.gif'),
          fadeInDuration: Duration( milliseconds: 15),
          fit: BoxFit.cover
        )
      ),
    );
  }

  Widget _posterTitle (Pelicula movie, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric( horizontal: 20.0),
      child: Row(
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
              image: NetworkImage( movie.getPosterImg() ),
              height: 150.0,
            ),
          ),
          SizedBox(width: 20.0),
          Flexible(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
            Text(movie.title, style: Theme.of(context).textTheme.bodyText1, overflow: TextOverflow.ellipsis),
            Text(movie.originalTitle, style: Theme.of(context).textTheme.subtitle2, overflow: TextOverflow.ellipsis,),
            Row(
              children: <Widget>[
                Icon( Icons.star_border),
                Text( movie.voteAverage.toString(), style: Theme.of(context).textTheme.subtitle2 )
              ]
            )
            ]
          )
          )
        ]
      )
    );
  }

  Widget _description ( Pelicula movie){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }

}