class Film {
  int id = 0;
  String titre = "";
  double note = 0.0;
  String dateDeSortie = "";
  String resume = "";
  String urlAffiche = "";

  Film(this.id, this.titre, this.note, this.dateDeSortie, this.resume,
      this.urlAffiche);

  Film.fromJson(Map<String, dynamic> chaineJson) {
    id = chaineJson['id'];
    titre = chaineJson['title'];
    note = chaineJson['vote_average'] * 1.0;
    dateDeSortie = chaineJson['release_date'];
    resume = chaineJson['overview'];
    urlAffiche = (chaineJson['poster_path']).toString();
  }
}
