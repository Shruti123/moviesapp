import 'package:flutter/material.dart';
import 'package:fujistu_demo/common/bloc_provider.dart';
import 'package:fujistu_demo/movieListIntegration/movieListBloc.dart';
import 'package:fujistu_demo/movieListIntegration/movieListScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        bloc: MovieListBloc(),
        child: MovieList(),
      )
    );
  }
}

