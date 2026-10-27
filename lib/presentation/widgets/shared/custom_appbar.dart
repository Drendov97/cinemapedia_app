import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/domain/repositories/movies_repository.dart';
import 'package:cinemapedia_app/presentation/providers/movies/movies_repository_provider.dart';
import 'package:flutter/material.dart';
import 'package:cinemapedia_app/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../delegates/search_movie_delegate.dart';

class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,//Toma todo el ancho posible
          child: Row(
            children: [
              Icon(Icons.movie_creation_outlined, color: colors.primary),
              const SizedBox(width: 5,),
              Text('Cinemapedia', style: titleStyle,),

              const Spacer(),

              IconButton (
                onPressed: () {


                  final movieRepository = ref.read(movieRepositoryProvider);
                  final searchQuery = ref.read(searchQueryProvider);

                  showSearch<Movie?> (
                    query: searchQuery,//Movie es opcional porque la persona puede que se salga
                    context: context,//de la busqueda sin mandar una pelicula
                     delegate: SearchMovieDelegate(

                      searchMovies: ref.read(searchedMoviesProvider.notifier).searchMoviesByQuery, initialMovies: []
                      /*
                      (query) {
                        ref.read(searchQueryProvider.notifier).update((state)=> query);
                        return movieRepository.searchMovies(query);}*/
                      
                      )
                     ).then((movie) {
                      if(movie == null) return;

                      context.push('/movie/${movie.id}');
                     });
                },

                 icon: const Icon(Icons.search)
                 )
            ],
          ),
        ),
        )
      );
  }
}