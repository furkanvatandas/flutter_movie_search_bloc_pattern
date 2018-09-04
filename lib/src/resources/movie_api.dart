import 'dart:async';
import 'dart:convert';
import 'package:bloc_movie/src/models/movie_model.dart';
import 'package:http/http.dart' as http;

//Your API Key
const _apiKey = "";
//The Movie DB Url
final _root = "https://api.themoviedb.org/3";
//Populer Movies URL
final _populerMoviesList = "$_root/movie/popular?api_key=$_apiKey&language=en-US";
//Query Movies URL
final _queryMoviesList = "$_root/search/movie?api_key=$_apiKey&language=en-US";

class MovieAPI {
  List<MovieModel> movieList = [];

  Future<List<MovieModel>> fetchPopulerMovies() async {
    if (movieList.isEmpty) {
      print("Emptyy");
      final http.Response response = await http.get(_populerMoviesList);
      final movies = json.decode(response.body)["results"];
      if (response.statusCode == 200) {
        movies.forEach((v) => movieList.add(MovieModel.fromJson(v)));
      } else {
        print("We have a problem about status 200");
      }
      return movieList;
    }
    return movieList;
  }
}
