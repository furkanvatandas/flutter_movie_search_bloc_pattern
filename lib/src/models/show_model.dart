import 'package:bloc_movie/src/models/entertainment.dart';

class ShowModel extends EntertainmentModel {
  @override
  //For tvShows API ["name"]
  ShowModel.fromJson(Map<String, dynamic> parsedJson)
      : title = parsedJson["name"],
        super.fromJson(parsedJson);

  String title;
}
