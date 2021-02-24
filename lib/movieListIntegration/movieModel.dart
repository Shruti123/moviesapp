import 'package:flutter/cupertino.dart';

class MovieModel {
  final posterPath;
  final originalTitle;
  final overview;
  final voteAverage;
  final title;
  final voteCount;
  final releaseDate;
  final language;
  final id ;

  MovieModel({@required this.id ,this.posterPath,this.originalTitle,this.overview,this.voteAverage,this.title,
  this.voteCount,this.releaseDate,this.language});

  factory MovieModel.fromJSON(Map<String,dynamic> json){
    return MovieModel(id: json['id'],
    title: json['title'] ,
    language:  json['original_language'],
    originalTitle:  json['original_title'],
    overview:  json['overview'],
    posterPath:  'https://www.themoviedb.org/t/p/w300_and_h450_bestv2/'+ json['poster_path'],
    releaseDate:  json['release_date'],
    voteAverage:  json['vote_average'],
    voteCount:  json['vote_count']);
  }
}