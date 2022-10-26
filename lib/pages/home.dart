import 'package:flutter/material.dart';
import 'package:news_app/pages/all_news.dart';
import 'package:news_app/pages/top_news.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  late TabController _tabController;
  int currentIndex = 0;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        currentIndex = _tabController.index;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: currentIndex == 0
              ? const Text("Top news")
              : const Text("All news"),
          bottom: TabBar(
            indicatorColor: Colors.indigo,
            controller: _tabController,
            tabs: const <Widget>[
              Tab(icon: Icon(Icons.toc)),
              Tab(icon: Icon(Icons.newspaper))
            ],
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const <Widget>[
                  Center(
                    child: TopNews(),
                  ),
                  Center(
                    child: AllNews(),
                  ),
                ],
              ),
            ),
            Container(
              width: 100.w,
              height: 5.h,
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 100.w,
                child: TextButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.bookmark, color: Colors.indigo),
                      Text(
                        "Bookmarks",
                        style: TextStyle(color: Colors.indigo, fontSize: 18.sp),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/bookmarks');
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
