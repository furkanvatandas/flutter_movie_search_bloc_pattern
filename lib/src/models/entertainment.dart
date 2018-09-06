abstract class EntertainmentModel {
  int id;
  String title;
  String posterPath;
  String overview;

  EntertainmentModel.fromJson(Map<String, dynamic> parsedJson)
      : id = parsedJson["id"],
        title = parsedJson["title"],
        posterPath = parsedJson["poster_path"],
        overview = parsedJson["overview"];
}
