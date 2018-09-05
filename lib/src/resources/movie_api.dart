import 'dart:async';
import 'dart:convert';
import 'package:bloc_movie/src/models/movie_model.dart';
import 'package:bloc_movie/src/models/tv_show_model.dart';
import 'package:http/http.dart' as http;

//Your API Key
const _apiKey = "c0cb6b1b4c08388f83df82589549f8bb";
//The Movie DB Url
final _root = "https://api.themoviedb.org/3";
//Populer Movies URL
final _populerMoviesList = "$_root/movie/popular?api_key=$_apiKey&language=en-US";
//Populer Shows URL
final _populerShowList = "$_root/tv/popular?api_key=$_apiKey&language=en-US";
//Query Movies URL
final _queryMoviesList = "$_root/search/movie?api_key=$_apiKey&language=en-US";

class MovieAPI {
  List<MovieModel> populerMovieList = [];
  List<TvShowModel> populerShowsList = [];

  Future<List<MovieModel>> fetchPopulerMovies() async {
    if (populerMovieList.isEmpty) {
      final http.Response response = await http.get(_populerMoviesList);
      final movies = json.decode(response.body)["results"];
      movies.forEach((v) => populerMovieList.add(MovieModel.fromJson(v)));
      return populerMovieList;
    }
    return populerMovieList;
  }

  Future<List<TvShowModel>> fetchPopulerShows() async {
    if (populerShowsList.isEmpty) {
      final http.Response response = await http.get(_populerShowList);
      final movies = json.decode(response.body)["results"];
      movies.forEach((v) => populerShowsList.add(TvShowModel.fromJson(v)));
      return populerShowsList;
    }
    return populerShowsList;
  }

  Future<List<MovieModel>> fetchQueryMovies(String query) async {
    List<MovieModel> queryMovieList = [];
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
