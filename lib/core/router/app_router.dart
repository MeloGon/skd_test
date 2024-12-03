import 'package:bloc/bloc.dart';
import 'package:ekd_test/features/home/presentation/screens/home_screen.dart';
import 'package:go_router/go_router.dart';

final _publicRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),

    //GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
  ],
);

class RouterCubit extends Cubit<GoRouter> {
  RouterCubit() : super(_publicRouter);

  void goBack() {
    state.pop();
  }

  void goHome() {
    state.push('/home');
  }
}
