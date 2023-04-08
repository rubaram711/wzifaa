import 'package:flutter/material.dart';
import 'package:wazefaa/backend/get_posts.dart';

import '../consts/colors.dart';
import '../widgets/Reusable_post_card_in_blog.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({Key? key}) : super(key: key);

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  List postsList = [];
  int from = 0;
  int length = 10;
  bool isLoadMore = false;
  bool isDataFetched = false;
  ScrollController scrollController = ScrollController();
  fetchData() async {
    var p = await getPosts('', from, length);
    postsList.addAll(p);
    scrollController.addListener(() async {
      if (isLoadMore) return;
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        setState(() async {
          isLoadMore = true;
          from = from + length;
          p = await getPosts('', from, length);
          postsList.addAll(p);
          setState(() {
            isLoadMore = false;
          });
        });
      }
    });
    setState(() {
      isDataFetched = true;
    });
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: MediaQuery.of(context).size.height * 0.10,
        backgroundColor: kBasicColor,
        title: const Text(
          'المدونة',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: isDataFetched
          ? Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                color: kBgColor,
                margin: const EdgeInsets.only(top: 5),
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                    controller: scrollController,
                    itemCount:
                        isLoadMore ? postsList.length + 1 : postsList.length,
                    itemBuilder: (context, index) {
                      if (index >= postsList.length) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return ReusablePostCard(
                            id: postsList[index]['ID'],
                            title: postsList[index]['post_title'],
                            content: postsList[index]['post_content'],
                            authorName: postsList[index]['author_name'],
                            postDate: postsList[index]['post_date'],
                            image: 'assets/images/blog.jpg',);
                      }
                    }),
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
