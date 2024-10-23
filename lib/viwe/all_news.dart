import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsday1/data/Silder_Category.dart';
import 'package:newsday1/data/aritcles_news_api.dart';
import 'package:newsday1/model/Silder_model.dart';
import 'package:newsday1/model/aritcles_model.dart';
import 'package:newsday1/model/category_news.dart';
import 'package:newsday1/viwe/aritacle_viwe.dart';

// ignore: must_be_immutable
class AllNews extends StatefulWidget {
  String news;
  AllNews({required this.news});

  @override
  State<AllNews> createState() => _AllNewsState();
}

class _AllNewsState extends State<AllNews> {
  List<ShowCategoryModel> Categories = [];
  List<SilderModel> silders = [];
  List<AritcleModel> articles = [];

  @override
  void initState() {
    getsilder();
    getNews();

    super.initState();
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {});
  }

  getsilder() async {
    silder newsClass = silder();
    await newsClass.getsilder();
    silders = newsClass.silders;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          title: Text(
            widget.news + "BrackingNews!",
            style: const TextStyle(
                color: Colors.blue, fontSize: 16, fontWeight: FontWeight.bold),
          )),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          itemCount:
              widget.news == "BrackingNews!" ? silders.length : articles.length,
          itemBuilder: (context, index) {
            return NewsAll(
              image: widget.news == "BrackingNews!"
                  ? silders[index].urlToImage!
                  : articles[index].urlToImage!,
              description: widget.news == "BrackingNews!"
                  ? silders[index].description!
                  : articles[index].description!,
              titel: widget.news == "BrackingNews!"
                  ? silders[index].title!
                  : articles[index].title!,
              url: widget.news == "BrackingNews!"
                  ? silders[index].url!
                  : articles[index].url!,
            );
          },
        ),
      ),
    );
  }
}

class NewsAll extends StatelessWidget {
  String image, description, titel, url;
  NewsAll(
      {required this.image,
      required this.description,
      required this.titel,
      required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Aritcleviwe(blogUrl: url)));
      },
      child: Container(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: CachedNetworkImage(
                imageUrl: image,
                width: MediaQuery.of(context).size.width,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              maxLines: 2,
              titel,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              maxLines: 3,
              description,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}
