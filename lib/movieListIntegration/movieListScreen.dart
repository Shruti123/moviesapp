import 'package:flutter/material.dart';
import 'package:fujistu_demo/common/bloc_provider.dart';
import 'package:fujistu_demo/common/circular_progress_indicator.dart';
import 'package:fujistu_demo/common/error_text_widget.dart';
import 'package:fujistu_demo/movieListIntegration/movieListBloc.dart';
import 'package:fujistu_demo/movieListIntegration/movieModel.dart';
import 'package:fujistu_demo/movieDetailsIntegration/moviesdetails.dart';

class MovieList extends StatefulWidget {
  EventModel model;

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList>  with AutomaticKeepAliveClientMixin<MovieList> {
  MovieListBloc movieListBloc;

  bool isLoading = false;
  List<MovieModel> itemList = List<MovieModel>();

  @override
  void initState() {
    super.initState();
    movieListBloc = BlocProvider.of<MovieListBloc>(context);
    movieListBloc.fetchMovieItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Fujistu Movies'),
        ),
        body: StreamBuilder(
            initialData: EventModel(true, null, null),
            stream: movieListBloc.eventStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              widget.model = snapshot.data;
              return _getPage(snapshot.data);
            })
    );
  }

  Widget _getPage(EventModel model) {
    isLoading = false;
    if (model.progress) {
      if (itemList.isEmpty) {
        return ProgressIndicatorWidget();
      } else {
        return _createGridView(itemList);
      }
    } else if (model.response != null) {
      if (itemList.contains(null)) {
        itemList.remove(null);
      }
      itemList.addAll(model.response);
      //itemList.add(null);
      return _createGridView(itemList);
    } else {
      if (itemList.isEmpty) {
        return ErrorTextWidget(model.error);
      } else {
        return _createGridView(itemList);
      }
    }
  }

  Widget _createGridView(List<MovieModel> itemList) {
    ScrollController _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.position.pixels) {
        if (!isLoading) {
          isLoading = !isLoading;
          //fetch more items for pagination
          movieListBloc.fetchMovieItems();
        }
      }
    });
      return GridView.count(
          crossAxisCount: 2,
          children: List.generate(itemList.length, (index) {
            MovieModel data = itemList[index];
            return InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) =>
                      MoviesDetails(
                        title: data.title,
                        posterPath: data.posterPath,
                        description: data.overview,
                        language: data.language,
                        releaseDate: data.releaseDate,
                        averageVotes: ' ${data.voteAverage}',
                      ),));
                },
                child: Image.network(
                  data.posterPath,
                  fit: BoxFit.cover,
                )
            );
          })
      );
  }

  @override
  bool get wantKeepAlive => true;
}
