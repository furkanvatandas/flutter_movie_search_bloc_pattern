import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:bloc_movie/src/resources/movie_api.dart';
import 'package:bloc_movie/src/models/entertainment.dart';

class PopulersBloc {
  final movieAPI = MovieAPI();
  final _populerMoviesSubject = BehaviorSubject<List<EntertainmentModel>>();
  final _populerShowsSubject = BehaviorSubject<List<EntertainmentModel>>();
  final _populerMovieDetailSubject = BehaviorSubject<EntertainmentModel>();

  //Sink
  Function get populerMoviesAdd => _populerMoviesSubject.sink.add;
  Function get populerShowsAdd => _populerShowsSubject.sink.add;
  Function get detailAdd => _populerMovieDetailSubject.sink.add;

  //Getter
  Observable<List<EntertainmentModel>> get populerMoviesStream => _populerMoviesSubject.stream;
  Observable<List<EntertainmentModel>> get populerShowsStream => _populerShowsSubject.stream;
  Observable<EntertainmentModel> get detailStream => _populerMovieDetailSubject.stream;

  fetchPopulerMovies() async {
    populerMoviesAdd(await movieAPI.fetchPopulerMovies());
  }

  fetchPopulerShows() async {
    populerShowsAdd(await movieAPI.fetchPopulerShows());
  }

  Future<Null> fetchPopulers() async {
    await fetchPopulerMovies();
    await fetchPopulerShows();
    return null;
  }

  void dispose() {
    _populerMoviesSubject.close();
    _populerMovieDetailSubject.close();
    _populerShowsSubject.close();
  }
}
