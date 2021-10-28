import 'package:flutter/material.dart';
import 'film.dart';

class DetailFilm extends StatelessWidget {
  final Film film;
  DetailFilm(this.film);

  @override
  Widget build(BuildContext context) {
    double hauteur = MediaQuery.of(context).size.height;
    final String urlBaseAffiche = 'https://image.tmdb.org/t/p/w500/';
    String chemin;
    if (film.urlAffiche != null) {
      chemin = urlBaseAffiche + film.urlAffiche;
    } else {
      chemin =
          'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(film.titre),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.swap_vert),
          tooltip: 'Échanger',
          onPressed: () {

          },
        ),
        body: SingleChildScrollView(
            child: Center(
                child: Column(
          children: <Widget>[
            Container(
                padding: const EdgeInsets.all(40),
                height: hauteur / 1.8,
                child: Image.network(chemin)),
            Container(
                padding: const EdgeInsets.only(bottom: 30),
                child: Column(
                  children: [
                    Text("Date de sortie " + film.dateDeSortie),
                    Text("Note : " + film.note.toString()),
                  ],
                )),
            Container(
                padding: const EdgeInsets.only(bottom: 30),
                child: const Text("Synopsys",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20))),
            Container(
              padding: const EdgeInsets.only(left: 40, right: 40),
              child: Text(film.resume),
            )
          ],
        ))));
  }
}
