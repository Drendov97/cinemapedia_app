import 'package:cinemapedia_app/config/constants/environment.dart';
import 'package:cinemapedia_app/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia_app/domain/entities/actor.dart';
import 'package:cinemapedia_app/infrastructure/mappers/actor_mapper.dart';
import 'package:cinemapedia_app/infrastructure/models/moviedb/credits_response.dart';
import 'package:dio/dio.dart';

//todo inicializar Dio obteniendo la URL de moviedb y la api key
//todo luego obtener la respuesta de la petición que deseamos obtener


class ActorMovieDbDatasource extends ActorsDatasource{

  final dio = Dio(BaseOptions(
    baseUrl: 'https://api.themoviedb.org/3/',
    queryParameters: {
      'api_key': Environment.theMovieDBKey,
      'language': 'es-MX'
    }
  ));

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async{

    final response = await dio.get(
      '/movie/$movieId/credits'
    );

    final castResponse = CastResponse.fromJson(response.data);





    List<Actor>actors = castResponse.cast.map(
      (cast) => ActorMapper.castToEntity(cast)
      ).toList();
    
    return actors;
  }

}