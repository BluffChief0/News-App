import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/api_service/api_service.dart';
import 'package:news_app/models/new.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'news_event.dart';

part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(const NewsInitial()) {
    on<NewsInitialize>(_onNewsInitialize);
    on<AddNewToFavorites>(_onAddNewToFavorite);
    on<LoadNewAllNews>(_onLoadNewAllNews);
    on<RefreshAllNews>(_onRefreshAllNews);
    on<RefreshTopNews>(_onRefreshTopNews);
  }

  void _onNewsInitialize(NewsInitialize event, emit) async {
    NewsLoading loadingState = const NewsLoading();
    emit(loadingState);

    NewsLoaded newState = NewsLoaded();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    newState.readFromSharedPrefs(prefs);

    List<New>? allNews = await ApiService.getAllArticles(1);
    List<New>? topNews = await ApiService.getTopArticles(1);
    allNews != null ? newState.allNews = allNews : newState.allNews = [];
    topNews != null ? newState.topNews = topNews : newState.topNews = [];

    if (allNews == null && topNews == null) {
      NewsError errorState = const NewsError();
      emit(errorState);
    } else {
      emit(newState);
    }
  }

  void _onAddNewToFavorite(AddNewToFavorites event, emit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    NewsLoaded newState = NewsLoaded.copyFrom(state as NewsLoaded);
    newState.readFromSharedPrefs(prefs);
    if (!newState.favoriteNews!.contains(event.article)) {
      newState.favoriteNews!.add(event.article);
    } else {
      newState.favoriteNews!.remove(event.article);
    }
    newState.writeToSharedPrefs(prefs);
    emit(newState);
  }

  void _onLoadNewAllNews(LoadNewAllNews event, emit) async {
    List<New>? newArticles = await ApiService.getAllArticles(event.page);
    NewsLoaded newState = NewsLoaded.copyFrom(state as NewsLoaded);

    if (newArticles != null) {
      newState.allNews = newState.allNews! + newArticles;
    }
    emit(newState);
  }

  void _onRefreshAllNews(RefreshAllNews event, emit) async {
    NewsLoaded newState = NewsLoaded.copyFrom(state as NewsLoaded);
    newState.allNews = [];
    List<New>? newArticles = await ApiService.getAllArticles(1);
    if (newArticles != null) {
      newState.allNews = newArticles;
    }
    emit(newState);
  }

  void _onRefreshTopNews(RefreshTopNews event, emit) async {
    if (state is NewsLoaded) {
      NewsLoaded newState = NewsLoaded.copyFrom(state as NewsLoaded);
      List<New>? newArticles = await ApiService.getTopArticles(1);

      if (newState.topNews != newArticles) {
        newState.topNews = newArticles;
      }
      emit(newState);
    }
  }
}
