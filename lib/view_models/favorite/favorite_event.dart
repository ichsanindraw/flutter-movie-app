part of 'favorite_bloc.dart';

sealed class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

class LoadFavorites extends FavoriteEvent {}

class AddToFavorites extends FavoriteEvent {
  final MovieModel movie;

  const AddToFavorites(this.movie);
}

class RemoveFromFavorites extends FavoriteEvent {
  final MovieModel movie;

  const RemoveFromFavorites(this.movie);
}

class RemoveAllFavorites extends FavoriteEvent {}
