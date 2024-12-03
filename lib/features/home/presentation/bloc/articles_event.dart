part of 'articles_bloc.dart';

sealed class ArticlesEvent extends Equatable {
  const ArticlesEvent();

  @override
  List<Object> get props => [];
}

class GetArticlesEvent extends ArticlesEvent {}

class RefreshArticlesEvent extends ArticlesEvent {}
