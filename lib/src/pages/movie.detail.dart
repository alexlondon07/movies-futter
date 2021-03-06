import 'package:flutter/material.dart';
import 'package:movies/src/pages/models/actor_model.dart';
import 'package:movies/src/pages/models/peliculas_model.dart';
import 'package:movies/src/providers/peliculas_provider.dart';

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
              _createCasting( movie ),
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
          Hero(
                tag: movie.id,
                child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image(
                  image: NetworkImage( movie.getPosterImg() ),
                  height: 140.0,
              ),
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

  Widget _createCasting( Pelicula movie){
    final movieProvider = new PeliculasProvider();

    return FutureBuilder(
      future: movieProvider.getCast(movie.id.toString()),
      builder: (context, AsyncSnapshot<List> snapshot) {
        if( snapshot.hasData ){
          return _createActorsPageView( snapshot.data );
        }else{
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _createActorsPageView ( List<Actor> actors){
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 1
        ),
        itemCount: actors.length,
        itemBuilder: (context, i) => _actorCard(actors[i])
      ),
    );
  }

  Widget _actorCard ( Actor actor){
    return Container(
      child: Column(
        children: <Widget>[
          ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
              image: NetworkImage( actor.getImg() ),
              placeholder: AssetImage('assets/img/no-image.jpg'),
              height: 140.0,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
          )
        ]
      )
    );
  }
}