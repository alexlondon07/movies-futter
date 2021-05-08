import 'package:movies/src/pages/models/peliculas_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PeliculasProvider {
  String _apikey = '8d3eca806af21ae7601404e882b506b8';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  // Peliculas en cine
  Future<List<Pelicula>> getNowPlaying() async{
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key' : _apikey,
      'language' : _language
    });
    final res = await http.get( url );
    final decodedData = json.decode(res.body);

    final movies = new Peliculas.fromJsonList(decodedData['results']);
    return movies.items;
  }
}