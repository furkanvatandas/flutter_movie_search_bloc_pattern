import 'dart:async';
import 'package:bloc_movie/src/models/tv_show_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:bloc_movie/src/models/movie_model.dart';
import 'package:bloc_movie/src/resources/movie_api.dart';

class PopulersBloc {
  final movieAPI = MovieAPI();
  final _populerMoviesSubject = BehaviorSubject<List<MovieModel>>();
  final _populerMovieDetailSubject = BehaviorSubject<MovieModel>();

  final _populerShowsSubject = BehaviorSubject<List<TvShowModel>>();
  final _populerShowDetailSubject = BehaviorSubject<TvShowModel>();

  //Sink
  Function get populerMoviesAdd => _populerMoviesSubject.sink.add;
  Function get populerMovieDetailAdd => _populerMovieDetailSubject.sink.add;

  Function get populerShowsAdd => _populerShowsSubject.sink.add;
  Function get populerShowDetailAdd => _populerShowDetailSubject.sink.add;

  //Getter
  Observable<List<MovieModel>> get populerMoviesStream => _populerMoviesSubject.stream;
  Observable<MovieModel> get populerMovieDetailStream => _populerMovieDetailSubject.stream;

  Observable<List<TvShowModel>> get populerShowsStream => _populerShowsSubject.stream;
  Observable<TvShowModel> get populerShowDetailStream => _populerShowDetailSubject.stream;

  Future<Null> fetchPopulerMovies() async {
    populerMoviesAdd(await movieAPI.fetchPopulerMovies());
    return null;
  }

  Future<Null> fetchPopulerShows() async {
    populerShowsAdd(await movieAPI.fetchPopulerShows());
    return null;
  }

  void dispose() {
    _populerMoviesSubject.close();
    _populerMovieDetailSubject.close();
    _populerShowsSubject.close();
    _populerShowDetailSubject.close();
  }
}
