import 'package:bloc_movie/src/models/movie_model.dart';
import 'package:bloc_movie/src/resources/movie_api.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc {
  final movieAPI = MovieAPI();
  final _querySubject = BehaviorSubject<String>();
  Observable<List<MovieModel>> _results;

  //Sink
  Function get queryAdd => _querySubject.sink.add;

  //Getter
  Observable<String> get queryStream => _querySubject.stream;
  Observable<List<MovieModel>> get results => _results;

  SearchBloc() {
    _results = queryStream.distinct().asyncMap(movieAPI.fetchQueryMovies);
  }

  void dispose() {
    _querySubject.close();
  }
}
