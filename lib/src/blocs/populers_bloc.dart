import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:bloc_movie/src/models/movie_model.dart';
import 'package:bloc_movie/src/resources/movie_api.dart';

class PopulersBloc {
  final movieAPI = MovieAPI();
  final _populerMoviesSubject = BehaviorSubject<List<MovieModel>>();
  final _populerMovieDetailSubject = BehaviorSubject<MovieModel>();

  //Sink
  Function get populerMoviesAdd => _populerMoviesSubject.sink.add;
  Function get populerMovieDetailAdd => _populerMovieDetailSubject.sink.add;

  //Getter
  Observable<List<MovieModel>> get populerMoviesStream => _populerMoviesSubject.stream;
  Observable<MovieModel> get populerMovieDetailStream => _populerMovieDetailSubject.stream;

  Future<Null> fetchPopulerMovies() async {
    populerMoviesAdd(await movieAPI.fetchPopulerMovies());
    return null;
  }

  void dispose() {
    _populerMoviesSubject.close();
    _populerMovieDetailSubject.close();
  }
}
