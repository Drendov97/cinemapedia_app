import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/presentation/providers/movies/movie_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


//Aquí se cambia el StatefulWidget por un ConsumerStatefulWidget
class MovieScreen extends ConsumerStatefulWidget {

  static const  name = 'movie-screen';

  final String movieId;


  const MovieScreen({super.key, required this.movieId});

//aquí se cambia el tipo de la funcion por _MovieScreenState
  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {

  @override
  void initState() {
 
    super.initState();

    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieId);

  }

  @override
  Widget build(BuildContext context) {

    //obtiene del movieInfoProvider el identificador de la pelicula
    final  Movie? movie = ref.watch(movieInfoProvider)[widget.movieId];

    if(movie == null){
      return const Scaffold(body:  Center(child: CircularProgressIndicator(strokeWidth: 2,),));
    }
    

    return Scaffold(
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _CustomSliverAppBar(movie: movie),
          SliverList(delegate: SliverChildBuilderDelegate(
            (context,index) => _MovieDetails(movie: movie),
            childCount: 1,
          ))
        ],
      ),
    );
  }
}

class _MovieDetails extends StatelessWidget {

  final Movie movie;
  const _MovieDetails({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final textStyles = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: const EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                movie.posterPath,
                width: size.width*0.3,
                ),
            ),

            const SizedBox(width: 10,),

            //Description

             SizedBox(
              width: (size.width  -40) * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.title, style: textStyles.titleLarge,),
                  Text(movie.overview),
                ],
              ),
              ),
          ],
        ),
        ),


      //movies Genres
      Padding(
        padding: const EdgeInsets.all(8),
        child: Wrap(
          children: [
            ...movie.genreIds.map((gender)=> Container(
              margin: const EdgeInsets.only(right: 10),
              child: Chip(
                label: Text(gender),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              
              ),
            ))
          ],
        ),
      ),

  //todo show ListView actors
        const SizedBox(height: 100,),
      ],
    );
  }
}

class _CustomSliverAppBar extends StatelessWidget {

  final Movie movie;

  const _CustomSliverAppBar({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {

    //obtiene las dimensiones del dispositivo
    final size = MediaQuery.of(context).size;

    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        title: Text(
          
          movie.title,
          style: const TextStyle(fontSize: 20,color: Colors.white),
          textAlign: TextAlign.start,

          ),
          background: Stack(
            children: [
              SizedBox.expand(
                child: Image.network(
                  movie.posterPath,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox.expand(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.7,1.0],
                      colors:  [
                        Colors.transparent,
                        Colors.black87,
                      ]
                      ),
                  )
                  ),
              ),

              const SizedBox.expand(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      
                      stops: [0.0,0.3],
                      colors:  [
                        Colors.black87,
                        Colors.transparent,
                        
                      ]
                      ),
                  )
                  ),
              ),

            ],
          ),
      ),
    );
  }
}