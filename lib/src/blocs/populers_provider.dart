import 'package:flutter/material.dart';
import 'package:bloc_movie/src/blocs/populers_bloc.dart';
export 'populers_bloc.dart';

class PopulersProvider extends InheritedWidget {
  final PopulersBloc populersBloc;

  PopulersProvider({Key key, Widget child})
      : populersBloc = PopulersBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static PopulersBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(PopulersProvider) as PopulersProvider)
        .populersBloc;
  }
}
