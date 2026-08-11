import 'package:cinemapedia_app/config/constants/environment.dart';
import 'package:cinemapedia_app/presentation/providers/movies/movies_providers.dart';
import 'package:cinemapedia_app/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:cinemapedia_app/presentation/providers/providers.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {

static const name = 'home-screen'; 

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:  _HomeView(),
      bottomNavigationBar: CustomBottomNavigationbar(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView({
    super.key,
  });

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {

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