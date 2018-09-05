import 'package:bloc_movie/src/blocs/populers_provider.dart';
import 'package:bloc_movie/src/blocs/search_provider.dart';
import 'package:bloc_movie/src/screens/home.dart';
import 'package:bloc_movie/src/screens/movie_detail.dart';
import 'package:flutter/material.dart';

class RootOfApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopulersProvider(
      child: SearchProvider(
        child: MaterialApp(
          title: 'Flutter Movie',
          onGenerateRoute: routes,
        ),
      ),
    );
  }

  Route routes(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (BuildContext context) {
          final bloc = PopulersProvider.of(context);
          bloc.fetchPopulerMovies();
          bloc.fetchPopulerShows();
          return Home();
        });
        break;
      case "/movieDetail":
        return MaterialPageRoute(builder: (BuildContext context) {
          return MovieDetail();
        });
        break;
    }
  }
}
