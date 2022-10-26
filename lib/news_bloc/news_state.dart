part of 'news_bloc.dart';

abstract class NewsState extends Equatable {
  const NewsState();
}

class NewsInitial extends NewsState {
  const NewsInitial();

  @override
  List<Object> get props => [];
}

class NewsLoading extends NewsState {
  const NewsLoading();

  @override
  List<Object?> get props => [];
}

class NewsError extends NewsState {
  const NewsError();

  @override
  List<Object?> get props => [];
}

class NewsLoaded extends NewsState {
  NewsLoaded();

  factory NewsLoaded.copyFrom(NewsLoaded other){
    NewsLoaded newState = NewsLoaded();
    newState.favoriteNews = other.favoriteNews;
    newState.topNews = other.topNews;
    newState.allNews = other.allNews;
    return newState;
  }

  List<New>? allNews;
  List<New>? topNews;
  List<New>? favoriteNews;

  Future<void> writeToSharedPrefs(SharedPreferences prefs) async {
    await prefs.setString('favoriteNews',
        jsonEncode(favoriteNews!.map((e) => e.toJSON()).toList()));
  }

  Future<void> readFromSharedPrefs(SharedPreferences prefs) async {
    List<dynamic> rawFavoriteNews;
    prefs.getString('favoriteNews') != null
        ? rawFavoriteNews =
            List<dynamic>.from(jsonDecode(prefs.getString('favoriteNews')!))
        : rawFavoriteNews = [];
    favoriteNews = rawFavoriteNews.map((e) => New.fromJSON(e)).toList();
  }

  @override
  List<Object?> get props => [allNews, topNews, favoriteNews];
}
