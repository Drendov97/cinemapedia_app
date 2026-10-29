import 'package:cinemapedia_app/presentation/providers/providers.dart';
import 'package:cinemapedia_app/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({
    super.key,
  });

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {

  @override
  void initState() {
    super.initState();
    
    //ref(//.notifier().loadNextPage())
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();

  }

  @override
  Widget build(BuildContext context) {

    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final slideShowMovies = ref.watch(moviesSlidshowProvider);
    final popularMovies = ref.watch(popularMoviesProvider);

    //if(nowPlayingMovies.length== 0) return CircularProgressIndicator();

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title:CustomAppbar(),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context,index){
              return Column(
        children: [
          
      
          MoviesSlideshow(movies: slideShowMovies),
      
          MoviesHorizontalListview(
            movies: nowPlayingMovies,
             title: 'En cines',
              subtitle: 'Lunes 20',
              loadNextPage: (){
                ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
              },
              ),
      
              MoviesHorizontalListview(
            movies: nowPlayingMovies,
             title: 'Proximamente',
              subtitle: 'Este Mes',
              loadNextPage: (){
                ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
              },
              ),
      
              MoviesHorizontalListview(
            movies: popularMovies,
             title: 'Populares',
              subtitle: 'Viernes 25',
              loadNextPage: (){
                ref.read(popularMoviesProvider.notifier).loadNextPage();
              },
              ),
      
      
      
        ],
      
      );
            },
            childCount: 1

          ),
          )
      ],
       
    );
  }
}