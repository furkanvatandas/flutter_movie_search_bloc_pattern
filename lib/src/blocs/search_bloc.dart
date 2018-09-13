import 'package:bloc_movie/src/models/entertainment.dart';
import 'package:bloc_movie/src/resources/movie_api.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc {
  final movieAPI = MovieAPI();
  final _querySubject = BehaviorSubject<String>();
  Observable<List<EntertainmentModel>> _results;

  //Sink
  Function get queryAdd => _querySubject.sink.add;

  //Getter
  Observable<String> get queryStream => _querySubject.stream;
  Observable<List<EntertainmentModel>> get results => _results;

  SearchBloc() {
    _results = queryStream
        .debounce(new Duration(milliseconds: 500))
        .distinct()
        .asyncMap(movieAPI.fetchQueryMovies);
  }

  void dispose() {
    _querySubject.close();
  }
}
