import 'dart:async';
import 'dart:convert';
import 'package:bloc_movie/src/models/entertainment.dart';
import 'package:bloc_movie/src/models/movie_model.dart';
import 'package:bloc_movie/src/models/show_model.dart';
import 'package:http/http.dart' as http;

//Your API Key !!! !!!
const _apiKey = "";
//The Movie DB Url
final _root = "https://api.themoviedb.org/3";
//Populer Movies URL
final _populerMoviesList = "$_root/movie/popular?api_key=$_apiKey&language=en-US";
//Populer Shows URL
final _populerShowList = "$_root/tv/popular?api_key=$_apiKey&language=en-US";
//Query Movies URL
final _queryMoviesList = "$_root/search/movie?api_key=$_apiKey&language=en-US";

class MovieAPI {
  List<EntertainmentModel> populerMovieList = [];
  List<EntertainmentModel> populerShowsList = [];

  Future<List<EntertainmentModel>> fetchPopulerMovies() async {
    if (populerMovieList.isEmpty) {
      final http.Response response = await http.get(_populerMoviesList);
      final movies = json.decode(response.body)["results"];
      movies.forEach((v) => populerMovieList.add(MovieModel.fromJson(v)));
      return populerMovieList;
    }
    return populerMovieList;
  }

  Future<List<EntertainmentModel>> fetchPopulerShows() async {
    if (populerShowsList.isEmpty) {
      final http.Response response = await http.get(_populerShowList);
      final movies = json.decode(response.body)["results"];
      movies.forEach((v) => populerShowsList.add(ShowModel.fromJson(v)));
      return populerShowsList;
    }
    return populerShowsList;
  }

  Future<List<EntertainmentModel>> fetchQueryMovies(String query) async {
    List<EntertainmentModel> queryMovieList = [];
    if (query.isNotEmpty) {
      if (queryMovieList.isEmpty) {
        final http.Response response =
            await http.get(_queryMoviesList + "&query=$query&page=1&include_adult=false");
        final movies = json.decode(response.body)["results"];
        if (movies.isEmpty) {
          return queryMovieList;
        } else {
          movies.forEach((v) => queryMovieList.add(MovieModel.fromJson(v)));
          return queryMovieList;
        }
      }
    } else {
      return null;
    }
  }
}
