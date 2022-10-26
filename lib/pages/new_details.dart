import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/api_service/api_service.dart';
import 'package:news_app/models/new.dart';
import 'package:news_app/news_bloc/news_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class NewDetails extends StatefulWidget {
  const NewDetails({Key? key, required this.news}) : super(key: key);
  final New news;

  @override
  State<NewDetails> createState() => _NewDetailsState();
}

class _NewDetailsState extends State<NewDetails> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            title: Text(widget.news.author ?? ('New' + "'s" + ' title')),
            backgroundColor: Colors.black,
            actions: [
              IconButton(
                splashRadius: 3.h,
                padding: EdgeInsets.zero,
                onPressed: () {
                  BlocProvider.of<NewsBloc>(context)
                      .add(AddNewToFavorites(widget.news));
                },
                icon: (state as NewsLoaded).favoriteNews!.contains(widget.news)
                    ? const Icon(Icons.bookmark_added)
                    : const Icon(Icons.bookmark_add),
              )
            ],
          ),
          body: Wrap(
            children: <Widget>[
              Center(
                child: Text(
                  widget.news.author ?? '',
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Text(
                widget.news.title ?? '',
                style: TextStyle(fontSize: 16.sp, color: Colors.white),
              ),
              SizedBox(
                height: 1.h,
              ),
              widget.news.urlToImage != null
                  ? Image.network(widget.news.urlToImage!)
                  : SizedBox(
                      height: 0.5.h,
                    ),
              Text(
                widget.news.description ?? '',
                style: TextStyle(fontSize: 16.sp, color: Colors.white),
              ),
              SizedBox(
                height: 1.h,
              ),
              TextButton(
                  onPressed: () async {
                    await launchUrl(Uri.parse(widget.news.url!));
                  },
                  child: const Text(
                    'Click here to open full version of article',
                    style: TextStyle(color: Colors.indigo),
                  ))
            ],
          ),
        );
      },
    );
  }
}
