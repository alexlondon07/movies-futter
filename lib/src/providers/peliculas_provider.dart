import 'dart:async';

import 'package:movies/src/pages/models/actor_model.dart';
import 'package:movies/src/pages/models/peliculas_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PeliculasProvider {
  String _apikey = '8d3eca806af21ae7601404e882b506b8';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';
  int _popularPage   = 0;
  bool _loading = false;
  List<Pelicula> _populars = [];

  final _popularsStreamController = StreamController<List<Pelicula>>.broadcast();
  Function(List<Pelicula>) get popularsSink => _popularsStreamController.add; // Agrega nuevas peliculas
  Stream<List<Pelicula>> get popularsStream => _popularsStreamController.stream; // Escuchando los datos

  void disposeStreams() {
    _popularsStreamController?.close();
  }

  // Peliculas en cine
  Future<List<Pelicula>> getNowPlaying() async {
    return _sendRequestGeneric('3/movie/now_playing');
  }

  // Peliculas populares
  Future<List<Pelicula>> getPopulars() async {

    if(_loading) return [];

    _loading = true;

    final resp = await  _sendRequestGeneric('3/movie/popular');

    _populars.addAll(resp);
    popularsSink ( _populars ); // Agregando aca más peliculas

    _loading = false;
    return resp;
  }

// Metodo para obtener los actores de la pelicula
  Future<List<Actor>> getCast( String movieId) async{
    final url = Uri.https(_url, '3/movie/$movieId/credits', {
      'api_key' : _apikey,
      'language' : _language
    });
    final res = await http.get( url );
    final decodedData = json.decode(res.body);
    final cast = new Cast.fromJsonList( decodedData['cast'] );
    return cast.actors;

  }

  // Metodo generico para enviar peticiones
  Future<List<Pelicula>> _sendRequestGeneric(endPoint) async {

    _popularPage++;
    final url = Uri.https(_url, endPoint, {
      'api_key' : _apikey,
      'language' : _language,
      'page'    : _popularPage.toString()
    });
    final res = await http.get( url );
    final decodedData = json.decode(res.body);

    final data = new Peliculas.fromJsonList(decodedData['results']);
    return data.items;
  }

}