import 'package:bloc_movie/src/blocs/populers_provider.dart';
import 'package:bloc_movie/src/models/movie_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MovieDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = PopulersProvider.of(context);
    return Scaffold(
        backgroundColor: Color(0xff37474f),
        body: SafeArea(
            minimum: EdgeInsets.symmetric(horizontal: 10.0),
            child: ListView(children: <Widget>[
              StreamBuilder(
                  stream: bloc.populerMovieDetailStream,
                  builder: (context, AsyncSnapshot<MovieModel> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return Container(
                      alignment: Alignment.center,
                      height: 400.0,
                      child: Hero(
                        tag: snapshot.data.id,
                        child: _buildPoster(snapshot),
                      ),
                    );
                  }),
              StreamBuilder(
                  stream: bloc.populerMovieDetailStream,
                  builder: (context, AsyncSnapshot<MovieModel> snapshot) {
                    if (!snapshot.hasData) {
                      return Text("loading...");
                    }
                    return _buildTitle(snapshot);
                  }),
              SizedBox(
                height: 10.0,
              ),
              StreamBuilder(
                  stream: bloc.populerMovieDetailStream,
                  builder: (context, AsyncSnapshot<MovieModel> snapshot) {
                    if (!snapshot.hasData) {
                      return Text("loading...");
                    }
                    return _buildOverview(snapshot);
                  }),
            ])));
  }

  Widget _buildPoster(AsyncSnapshot<MovieModel> snapshot) {
    return Card(
      margin: EdgeInsets.all(10.0),
      color: Colors.transparent,
      elevation: 6.0,
      child: CachedNetworkImage(
        width: 200.0,
        height: 300.0,
        imageUrl: "https://image.tmdb.org/t/p/w500${snapshot.data.posterPath}",
        placeholder: Container(
          width: 200.0,
          height: 300.0,
        ),
        errorWidget: Container(
          width: 200.0,
          height: 300.0,
          alignment: Alignment.center,
          child: new Icon(Icons.error),
        ),
      ),
    );
  }

  Widget _buildTitle(AsyncSnapshot<MovieModel> snapshot) {
    return Text(
      snapshot.data.title,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.white70, fontSize: 22.0, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildOverview(AsyncSnapshot<MovieModel> snapshot) {
    return Text(
      snapshot.data.overview,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.white70, height: 1.4),
    );
  }
}
