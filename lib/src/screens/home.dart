import 'package:flutter/material.dart';
import 'package:bloc_movie/src/blocs/search_provider.dart';
import 'package:bloc_movie/src/models/entertainment.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:bloc_movie/src/blocs/populers_provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final populerBloc = PopulersProvider.of(context);
    final searchBloc = SearchProvider.of(context);
    return Scaffold(
      backgroundColor: Color(0xff37474f),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => populerBloc.fetchPopulers(),
          child: ListView(
            children: <Widget>[
              Card(
                margin: EdgeInsets.all(20.0),
                elevation: 8.0,
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    hintText: "Search Movie",
                    border: InputBorder.none,
                    //focusedBorder: InputBorder.none,
                  ),
                  onChanged: searchBloc.queryAdd,
                ),
              ),

              //Searching Title
              StreamBuilder(
                  stream: searchBloc.queryStream,
                  builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (!snapshot.hasData || snapshot.data.isEmpty) {
                      return Container();
                    }

                    return Text(
                      "Searching: ${snapshot.data}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }),
              SizedBox(
                height: 20.0,
              ),
              //Searching Movies
              StreamBuilder(
                stream: searchBloc.results,
                builder: (BuildContext context, AsyncSnapshot<List<EntertainmentModel>> snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  } else if (snapshot.data.isEmpty) {
                    return Container(
                      height: 100.0,
                      child: Center(
                          child: Text(
                        "Sorry No Data",
                        style: TextStyle(
                          color: Colors.white30,
                          fontSize: 18.0,
                        ),
                      )),
                    );
                  }
                  return Container(
                    height: 350.0,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return _buildMovieItem(context, index, snapshot, populerBloc);
                        }),
                  );
                },
              ),
              Text(
                "Popular Movies",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              //Populer Movies
              StreamBuilder(
                stream: populerBloc.populerMoviesStream,
                builder: (BuildContext context, AsyncSnapshot<List<EntertainmentModel>> snapshot) {
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
                          return _buildMovieItem(context, index, snapshot, populerBloc);
                        }),
                  );
                },
              ),
              SizedBox(
                height: 40.0,
              ),
              Text(
                "Popular Shows",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              //Populer Shows
              StreamBuilder(
                stream: populerBloc.populerShowsStream,
                builder: (BuildContext context, AsyncSnapshot<List<EntertainmentModel>> snapshot) {
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
                          return _buildMovieItem(context, index, snapshot, populerBloc);
                        }),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMovieItem(BuildContext context, int index,
      AsyncSnapshot<List<EntertainmentModel>> snapshot, PopulersBloc bloc) {
    return Column(children: <Widget>[
      GestureDetector(
        onTap: () {
          bloc.detailAdd(snapshot.data[index]);
          Navigator.pushNamed(context, "/movieDetail");
        },
        child: _buildCacheImage(snapshot, index),
      ),
      //Movie Title
      Container(
        width: 200.0,
        height: 30.0,
        alignment: Alignment.center,
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

  Widget _buildCacheImage(AsyncSnapshot<List<EntertainmentModel>> snapshot, int index) {
    //Movie Image
    return Card(
      margin: EdgeInsets.all(5.0),
      color: Colors.transparent,
      elevation: 4.0,
      child: snapshot.data[index].posterPath != null
          ? CachedNetworkImage(
              width: 200.0,
              height: 300.0,
              imageUrl: "https://image.tmdb.org/t/p/w500${snapshot.data[index].posterPath}",
              fit: BoxFit.contain,
              placeholder: Container(
                width: 200.0,
                height: 300.0,
                child: Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.black54,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black54),
                  ),
                ),
              ),
              errorWidget: Container(
                height: 300.0,
                alignment: Alignment.center,
                child: new Icon(Icons.error),
              ),
            )
          : Container(
              width: 200.0,
              height: 300.0,
              child: Center(
                child: new Icon(Icons.error),
              ),
            ),
    );
  }
}
