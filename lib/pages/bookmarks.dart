import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/models/new.dart';
import 'package:news_app/models/source.dart';
import 'package:news_app/news_bloc/news_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Bookmarks extends StatefulWidget {
  const Bookmarks({Key? key}) : super(key: key);

  @override
  State<Bookmarks> createState() => _BookmarksState();
}

class _BookmarksState extends State<Bookmarks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Bookmarks'),
        backgroundColor: Colors.black,
      ),
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          return (state is NewsLoaded)
              ? ListView(children: state.favoriteNews!.map(_newTile).toList())
              : const Text('Error');
        },
      ),
    );
  }

  Widget _newTile(New news) {
    return TextButton(
      onPressed: () {
        Navigator.pushNamed(context, '/details', arguments: {'news': news});
      },
      child: Container(
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
