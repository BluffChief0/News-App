import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/models/new.dart';
import 'package:news_app/news_bloc/news_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AllNews extends StatefulWidget {
  const AllNews({Key? key}) : super(key: key);

  @override
  State<AllNews> createState() => _AllNewsState();
}

class _AllNewsState extends State<AllNews> {
  int currentPage = 1;

  // макс число запросов для бесплатной версии 100, следовательно 15*6=90, 6 - макс число страниц
  // при попытке запроса на 7 странице, выдает 426 ошибку
  int maxPage = 6;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        if (state is NewsLoading) {
          return const CircularProgressIndicator(
            color: Colors.white,
          );
        } else if (state is NewsLoaded) {
          return RefreshIndicator(
            color: Colors.indigo,
            onRefresh: _onRefresh,
            child: ListView.builder(
              itemCount: state.allNews!.length,
              itemBuilder: (context, index) {
                if (index == state.allNews!.length - 1 &&
                    currentPage < maxPage) {
                  currentPage++;
                  BlocProvider.of<NewsBloc>(context)
                      .add(LoadNewAllNews(currentPage));
                }
                return _newTile(state.allNews![index]);
              },
              // children: (state.allNews ?? []).map(_newTile).toList(),
            ),
          );
        } else {
          return Center(
              child: Text(
            'Error. Probably, you have sent too much requests. Try to run app later.',
            style: TextStyle(color: Colors.white, fontSize: 20.sp),
          ));
        }
      },
    );
  }

  Future<void> _onRefresh() async {
    currentPage = 1;
    BlocProvider.of<NewsBloc>(context).add(const RefreshAllNews());
  }

  Widget _newTile(New news) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, '/details', arguments: {'news': news});
      },
      child: SizedBox(
          width: 100.w,
          // height: 20.h,
          child: Wrap(
            children: <Widget>[
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Center(
                    child: Text(
                  news.author ?? '',
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  news.title ?? '',
                  style: TextStyle(fontSize: 16.sp, color: Colors.white),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  news.description ?? '',
                  style: TextStyle(fontSize: 14.sp, color: Colors.white),
                ),
                Divider(
                  color: Colors.indigo,
                  thickness: 0.5.h,
                ),
              ])
            ],
          )),
    );
  }
}
