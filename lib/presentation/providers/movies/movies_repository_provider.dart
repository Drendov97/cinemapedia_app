import 'package:cinemapedia_app/infrastructure/datasources/the_moviedb_datasource.dart';
import 'package:cinemapedia_app/infrastructure/repositories/movie_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Este repositorio es inmutable (solo lectura)
final movieRepositoryProvider = Provider((ref) {

  return MovieRepositoryImpl(TheMoviedbDatasource());
});