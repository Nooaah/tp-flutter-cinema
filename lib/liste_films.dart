import 'package:flutter/material.dart';
import 'http_helper.dart';
import 'detail_film.dart';

class ListeFilms extends StatefulWidget {
  const ListeFilms({Key? key}) : super(key: key);

  @override
  _ListeFilmsState createState() => _ListeFilmsState();
}

class _ListeFilmsState extends State<ListeFilms> {
  String resultat = "";
  HttpHelper? helper;
  int? nombreDeFilms;
  List? films;
  final String urlImageBase = 'https://image.tmdb.org/t/p/w92/';
  final String imageParDefaut =
      'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';
  Icon iconVisible = Icon(Icons.search);
  Widget barreRecherche = Text('Films');

  @override
  void initState() {
    helper = HttpHelper();
    initialiser();
    super.initState();
  }

  Future initialiser() async {
    films = await helper!.recevoirNouveauxFilms();
    setState(() {
      nombreDeFilms = films!.length;
      films = films;
    });
  }

  Future rechercher(texte) async {
    films = await helper!.rechercherFilms(texte);
    setState(() {
      nombreDeFilms = films!.length;
      films = films;
    });
  }

  @override
  Widget build(BuildContext context) {
    NetworkImage image;
    return Scaffold(
        appBar: AppBar(title: barreRecherche, actions: <Widget>[
          IconButton(
            icon: iconVisible,
            onPressed: () {
              setState(() {
                if (iconVisible.icon == Icons.search) {
                  iconVisible = Icon(Icons.cancel);
                  barreRecherche = TextField(
                      textInputAction: TextInputAction.search,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                      onSubmitted: (String text) {
                        rechercher(text);
                      });
                } else {
                  setState(() {
                    iconVisible = const Icon(Icons.search);
                    barreRecherche = const Text('Films');
                  });
                }
              });
            },
          ),
        ]),
        body: ListView.builder(
            itemCount: (this.nombreDeFilms == null) ? 0 : this.nombreDeFilms,
            itemBuilder: (BuildContext context, int position) {
              if (films![position].urlAffiche != null) {
                image =
                    NetworkImage(urlImageBase + films![position].urlAffiche);
              } else {
                image = NetworkImage(imageParDefaut);
              }
              return Card(
                  color: Colors.white,
                  elevation: 2.0,
                  child: ListTile(
                    onTap: () {
                      MaterialPageRoute route = MaterialPageRoute(
                          builder: (_) => DetailFilm(films![position]));
                      Navigator.push(context, route);
                    },
                    leading: CircleAvatar(
                      backgroundImage: image,
                    ),
                    title: Text(films![position].titre),
                    subtitle: Text('Date de sortie : ' +
                        films![position].dateDeSortie +
                        ' - Note : ' +
                        films![position].note.toString()),
                  ));
            }));
  }
}
