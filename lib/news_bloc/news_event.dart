part of 'news_bloc.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();
}

class NewsInitialize extends NewsEvent {
  const NewsInitialize();

  @override
  List<Object?> get props => [];
}

class AddNewToFavorites extends NewsEvent {
  final New article;
  const AddNewToFavorites(this.article);

  @override
  List<Object?> get props => [article];
}

class LoadNewAllNews extends NewsEvent {
final int page;
const LoadNewAllNews(this.page);

@override
List<Object?> get props => [page];
}

class LoadNewTopNews extends NewsEvent {
  final int page;
  const LoadNewTopNews(this.page);

  @override
  List<Object?> get props => [page];
}

class RefreshAllNews extends NewsEvent {
  const RefreshAllNews();

  @override
  List<Object?> get props => [];
}

class RefreshTopNews extends NewsEvent {
  const RefreshTopNews();

  @override
  List<Object?> get props => [];
}