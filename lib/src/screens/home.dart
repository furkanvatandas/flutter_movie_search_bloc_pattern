import 'package:bloc_movie/src/models/movie_model.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:bloc_movie/src/blocs/populers_provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = PopulersProvider.of(context);
    return Scaffold(
      backgroundColor: Color(0xff37474f),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Text(
              "Popular Movies",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            StreamBuilder(
              stream: bloc.populerMoviesStream,
              builder: (BuildContext context, AsyncSnapshot<List<MovieModel>> snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                    height: 350.0,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                return Container(
                  height: 350.0,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return _buildMovieItem(context, index, snapshot, bloc);
                      }),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMovieItem(
      BuildContext context, int index, AsyncSnapshot<List<MovieModel>> snapshot, bloc) {
    return Column(children: <Widget>[
      GestureDetector(
        onTap: () {
          bloc.populerMovieDetailAdd(snapshot.data[index]);
          Navigator.pushNamed(context, "/movieDetail");
        },
        child: Hero(
          tag: snapshot.data[index].id,
          child: _buildCacheImage(snapshot, index),
        ),
      ),
      //Movie Title
      Container(
        width: 200.0,
        child: Text(
          snapshot.data[index].title,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: Colors.white70, fontSize: 16.0, fontWeight: FontWeight.bold),
        ),
      ),
    ]);
  }

  Widget _buildCacheImage(AsyncSnapshot<List<MovieModel>> snapshot, int index) {
    //Movie Image
    return Card(
      margin: EdgeInsets.all(5.0),
      color: Colors.transparent,
      elevation: 6.0,
      child: CachedNetworkImage(
        width: 200.0,
        height: 300.0,
        imageUrl: "https://image.tmdb.org/t/p/w500${snapshot.data[index].posterPath}",
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
}
