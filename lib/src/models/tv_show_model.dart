class TvShowModel {
  int id;
  String title;
  String posterPath;
  String overview;

  TvShowModel.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson["id"],
        title = parsedJson["name"],
        posterPath = parsedJson["poster_path"],
        overview = parsedJson["overview"];
}
