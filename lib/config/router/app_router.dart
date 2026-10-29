import 'package:cinemapedia_app/presentation/screens/movies/home_screen.dart';
import 'package:cinemapedia_app/presentation/views/home_views/favorites_view.dart';
import 'package:cinemapedia_app/presentation/views/views.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/screens/screens.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: HomeScreen.name,
      builder: (context,state) => const HomeScreen(childView: HomeView(),)
    ),

    GoRoute(
      path: '/movie/:id',
      name: MovieScreen.name,
      builder: (context,state) {
        final movieId = state.pathParameters['id'] ?? 'no-id';


        return  MovieScreen(movieId: movieId,);
      } 
    ),
    
  ],
  
  );