import 'package:bloc_movie/src/blocs/search_bloc.dart';
import 'package:flutter/material.dart';
export 'populers_bloc.dart';

class SearchProvider extends InheritedWidget {
  final SearchBloc searchBloc;

  SearchProvider({Key key, Widget child})
      : searchBloc = SearchBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static SearchBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(SearchProvider) as SearchProvider).searchBloc;
  }
}
