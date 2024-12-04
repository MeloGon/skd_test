part of 'articles_bloc.dart';

sealed class ArticlesState extends Equatable {
  const ArticlesState();

  @override
  List<Object> get props => [];
}

final class ArticlesInitialState extends ArticlesState {}

final class ArticlesLoadingState extends ArticlesState {}

final class ArticlesLoadedState extends ArticlesState {
  final List<Article> articles;
  const ArticlesLoadedState({required this.articles});
  @override
  List<Object> get props => [articles];
}

final class ArticlesErrorState extends ArticlesState {
  final String message;
  const ArticlesErrorState({required this.message});
  @override
  List<Object> get props => [message];
}
