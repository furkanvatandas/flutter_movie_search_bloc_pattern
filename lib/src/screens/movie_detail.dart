import 'package:bloc_movie/src/blocs/populers_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MovieDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = PopulersProvider.of(context);
    return Scaffold(
        backgroundColor: Color(0xff37474f),
        body: SafeArea(
            child: StreamBuilder(
                stream: bloc.detailStream,
                builder: (context, AsyncSnapshot<dynamic> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return ListView(children: <Widget>[
                    _buildPoster(snapshot),
                    SizedBox(
                      height: 20.0,
                    ),
                    _buildTitle(snapshot),
                    SizedBox(
                      height: 20.0,
                    ),
                    _buildOverview(snapshot),
                  ]);
                })));
  }

  Widget _buildPoster(AsyncSnapshot<dynamic> snapshot) {
    return CachedNetworkImage(
      width: 200.0,
      height: 400.0,
      imageUrl: "https://image.tmdb.org/t/p/w500${snapshot.data.posterPath}",
      fit: BoxFit.cover,
      alignment: Alignment.topCenter,
      placeholder: Container(
        height: 300.0,
      ),
      errorWidget: Container(
        height: 300.0,
        alignment: Alignment.center,
        child: new Icon(Icons.error),
      ),
    );
  }

  Widget _buildTitle(AsyncSnapshot<dynamic> snapshot) {
    return Text(
      snapshot.data.title,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.white70, fontSize: 22.0, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildOverview(AsyncSnapshot<dynamic> snapshot) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: Text(
        snapshot.data.overview,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white70, height: 1.4),
      ),
    );
  }
}
