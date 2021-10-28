import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'film.dart';

class HttpHelper {
  final String urlBase = 'https://api.themoviedb.org/3/movie';
  final String urlCmd = '/upcoming?';
  final String urlKey = 'api_key=ecc5442c1df699f167d368361168e0fd';
  final String urlLanguage = '&language=fr-FR';
  final String urlRecherche =
      'https://api.themoviedb.org/3/search/movie?api_key=ecc5442c1df699f167d368361168e0fd&language=fr-FR&query=';

  Future<List> recevoirNouveauxFilms() async {
    final String urlNouveauxFilms = urlBase + urlCmd + urlKey + urlLanguage;

    http.Response resultat = await http.get(Uri.parse(urlNouveauxFilms));
    if (resultat.statusCode == HttpStatus.ok) {
      final chaineJSON = json.decode(resultat.body);
      final filmsMap = chaineJSON['results'];
      List films = filmsMap.map((i) => Film.fromJson(i)).toList();
      return films;
    } else {
      return [];
    }
  }

  Future<List> rechercherFilms(String titre) async {
    final String query = urlRecherche + titre;
    http.Response resultat = await http.get(Uri.parse(query));
    if (resultat.statusCode == HttpStatus.ok) {
      final reponseJson = json.decode(resultat.body);
      final filmsMap = reponseJson['results'];
      List films = filmsMap.map((i) => Film.fromJson(i)).toList();
      return films;
    } else {
      return [];
    }
  }
}
