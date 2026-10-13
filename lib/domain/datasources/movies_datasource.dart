import 'package:cinemapedia_app/domain/entities/movie.dart';

abstract class MoviesDatasource {
  Future<List<Movie>> getNowPlaying({int page = 1});
  Future<List<Movie>> getPopular({int page = 1});
  Future<List<Movie>> searchMovies(String query);
  Future<Movie> getMovieById(String id);

}