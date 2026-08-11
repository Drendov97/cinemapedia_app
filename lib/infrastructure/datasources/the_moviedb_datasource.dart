import 'package:cinemapedia_app/config/constants/environment.dart';
import 'package:cinemapedia_app/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia_app/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

class TheMoviedbDatasource extends MoviesDatasource{
  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3/',
    queryParameters: {
      'api_key': Environment.theMovieDBKey,
      'language': 'es-MX'
    }
  ));


  List<Movie> _jsonToMovies(Map<String,dynamic>json){
 final movieDBResponse = MovieDbResponse.fromJson(json);


    final List<Movie> movies = movieDBResponse.results.map(
      (moviedb) => MovieMapper.movieDBToEntity(moviedb)
      ).toList();

    return movies;
  }
  
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async{

    final response = await dio.get('movie/now_playing',
    queryParameters: {
      'page': page
    }
    );
   return _jsonToMovies(response.data);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    // TODO: implement getPopular
    final response = await dio.get('movie/popular',
    queryParameters: {
      'page': page
    }
    );
    return _jsonToMovies(response.data);
    
  }

}