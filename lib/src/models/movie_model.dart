class MovieModel {
  int id;
  int voteCount;
  num voteAverage;
  String title;
  String posterPath;
  String overview;
  String releaseDay;

  MovieModel.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson["id"],
        voteCount = parsedJson["vote_count"],
        voteAverage = parsedJson["vote_average"],
        title = parsedJson["title"],
        posterPath = parsedJson["poster_path"],
        overview = parsedJson["overview"],
        releaseDay = parsedJson["release_date"];
}
