import 'package:bloc_movie/src/models/entertainment.dart';

class MovieModel extends EntertainmentModel {
  //For tvShows API ["title"]
  MovieModel.fromJson(Map<String, dynamic> parsedJson)
      : title = parsedJson["title"],
        super.fromJson(parsedJson);

  String title;
}
