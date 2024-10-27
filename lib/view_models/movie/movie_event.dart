part of 'movie_bloc.dart';

sealed class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
}

class GetMoviesEvent extends MovieEvent {}

class LoadMoreEvent extends MovieEvent {}
