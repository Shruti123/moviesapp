import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MoviesDetails extends StatelessWidget {
  final posterPath;
  final title;
  final description;
  final releaseDate;
  final averageVotes;
  final language;

  MoviesDetails({this.posterPath,this.title,this.description,this.releaseDate,this.averageVotes,
  this.language});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Details'),
    ),
    body: Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color.fromRGBO(0, 0, 0, 0.5),
          image: DecorationImage(
              image: NetworkImage(posterPath),
              fit: BoxFit.fill,
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.dstATop)
          )
      ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
               child: Column(
                children: [
                  _bannerImage(posterPath),
                  SizedBox(height: 20,),
                  Text(title,style: titleStyle,),
                  SizedBox(height: 30,),
                  Text(description,style: subtitleStyle,),
                  SizedBox(height: 30,),
                  _moviesVotesInfo('Average Votes',averageVotes),
                  SizedBox(height: 10,),
                  _moviesVotesInfo('Release Date',releaseDate),
                  SizedBox(height: 10,),
                  _moviesVotesInfo('Language',language),
                ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _bannerImage(String imgUrl){
    return Image.network(imgUrl,fit: BoxFit.cover,
    height: 300,
    width: 220,);
  }

  Widget _moviesVotesInfo(String leftVal, String rightValue){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(leftVal,style: textStyle,),
        Text(rightValue,style: textStyle,)
      ],
    );
  }

  final titleStyle = TextStyle(fontSize: 22,color: Colors.white,fontWeight: FontWeight.bold);
  final subtitleStyle = TextStyle(fontSize: 17,color: Colors.white,fontWeight: FontWeight.w200);
  final textStyle = TextStyle(fontSize: 19,color: Colors.white,fontWeight: FontWeight.w500);
}
