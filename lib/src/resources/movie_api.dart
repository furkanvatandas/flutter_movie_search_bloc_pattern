import 'dart:async';
import 'dart:convert';
import 'package:bloc_movie/src/models/movie_model.dart';
import 'package:http/http.dart' as http;

//Your API Key
const _apiKey = "c0cb6b1b4c08388f83df82589549f8bb";
//The Movie DB Url
final _root = "https://api.themoviedb.org/3";
//Populer Movies URL
final _populerMoviesList = "$_root/movie/popular?api_key=$_apiKey&language=en-US";
//Query Movies URL
final _queryMoviesList = "$_root/search/movie?api_key=$_apiKey&language=en-US";

class MovieAPI {
  List<MovieModel> populerMovieList = [];

  Future<List<MovieModel>> fetchPopulerMovies() async {
    if (populerMovieList.isEmpty) {
      print("Emptyy");
      final http.Response response = await http.get(_populerMoviesList);
      final movies = json.decode(response.body)["results"];
      if (response.statusCode == 200) {
        movies.forEach((v) => populerMovieList.add(MovieModel.fromJson(v)));
      } else {
        print("We have a problem about status 200");
      }
      return populerMovieList;
    }
    return populerMovieList;
  }

  Future<List<MovieModel>> fetchQueryMovies(String query) async {
    List<MovieModel> queryMovieList = [];
    if (queryMovieList.isEmpty) {
      if (query.isEmpty) {
        return null;
      } else {
        final http.Response response =
            await http.get(_queryMoviesList + "&query=$query&page=1&include_adult=false");
        final List movies = json.decode(response.body)["results"];
        if (response.statusCode == 200) {
          if (movies.isEmpty) {
            return queryMovieList;
          } else {
            movies.forEach((v) => queryMovieList.add(MovieModel.fromJson(v)));
            return queryMovieList;
          }
        } else {
          print("We have a problem about status 200");
        }
      }
    } else {
      return queryMovieList;
    }
  }
}
