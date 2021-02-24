import 'dart:async';

import 'package:fujistu_demo/common/BaseBloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'movieModel.dart';

class MovieListBloc extends BaseBloc {

  StreamController<EventModel> _eventController = new StreamController();
  Sink<EventModel> get _eventSink => _eventController.sink;
  Stream<EventModel> get eventStream => _eventController.stream;


  void fetchMovieItems() {
    Observable.fromFuture(_fetchMovieItems()).doOnListen(() {
      _eventSink.add(EventModel(true, null, null));
    }).doOnError((error, stacktrace) {
      _eventSink.add(EventModel(false, null, error.toString()));
    }).listen((itemList) {
      List<MovieModel> movieItems = itemList;
      _eventSink.add(EventModel(false, movieItems, null));
    });
  }


  Future<List<MovieModel>> _fetchMovieItems() async {
    final response =
    await http.get(
        'http://api.themoviedb.org/3/movie/popular?api_key=959c3a135964e4032af16d2d12e571e7');
    if (response.statusCode != 200) {
      throw Exception();
    }
    return parseJson(response.body);
  }

  List<MovieModel> parseJson(final response) {
    final jsonDecoded = json.decode(response);
    List<MovieModel> movieModels = [];
    for (var result in jsonDecoded['results']) {
      movieModels.add(MovieModel.fromJSON(result));
    }
    return movieModels;
  }

  @override
  void dispose() {
    _eventController.close();
  }


}

class EventModel {
  final bool progress;
  final List<MovieModel> response;
  final String error;

  EventModel(this.progress, this.response, this.error);
}