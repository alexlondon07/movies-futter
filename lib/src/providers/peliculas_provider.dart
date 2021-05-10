import 'package:movies/src/pages/models/peliculas_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PeliculasProvider {
  String _apikey = '8d3eca806af21ae7601404e882b506b8';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  // Peliculas en cine
  Future<List<Pelicula>> getNowPlaying() async {
    return _sendRequestGeneric('3/movie/now_playing');
  }
  // Peliculas populares
  Future<List<Pelicula>> getPopulars() async {
    return _sendRequestGeneric('3/movie/popular');
  }

  Future<List<Pelicula>> _sendRequestGeneric(endPoint) async {
    final url = Uri.https(_url, endPoint, {
      'api_key' : _apikey,
      'language' : _language
    });
    final res = await http.get( url );
    final decodedData = json.decode(res.body);

    final data = new Peliculas.fromJsonList(decodedData['results']);
    return data.items;
  }

}