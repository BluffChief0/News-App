import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/models/new.dart';
import 'package:news_app/news_bloc/news_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class TopNews extends StatefulWidget {
  const TopNews({Key? key}) : super(key: key);

  @override
  State<TopNews> createState() => _TopNewsState();
}

class _TopNewsState extends State<TopNews> {

  @override
  void initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 5), (Timer t) {
      if (mounted) {
        BlocProvider.of<NewsBloc>(context).add(const RefreshTopNews());
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        if (state is NewsLoading) {
          return const CircularProgressIndicator(
            color: Colors.white,
          );
        } else if (state is NewsLoaded){
          return ListView(
            children: (state.topNews ?? []).map(_newTile).toList(),
          );} else{
        return Center(
            child: Text(
              'Error. Probably, you have sent too much requests. Try to run app later.',
              style: TextStyle(color: Colors.white, fontSize: 20.sp),
            ));}
      },
    );
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
                      style:
                      TextStyle(fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  news.title ?? '',
                  style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.white
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  news.description ?? '',
                  style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.white
                  ),
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