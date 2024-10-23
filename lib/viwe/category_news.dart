import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsday1/data/category_news.dart';
import 'package:newsday1/data/data_category.dart';
import 'package:newsday1/model/category_news.dart';
import 'package:newsday1/viwe/aritacle_viwe.dart';

class CategoryNews extends StatefulWidget {
  String name;
  CategoryNews({required this.name});

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  // ignore: unused_field
  List<ShowCategoryModel> Categories = [];
  bool _Loading = true;

  @override
  void initState() {
    getNews();
    super.initState();
  }

  getNews() async {
    ShowCategoryNews showCategoryNews = ShowCategoryNews();
    await showCategoryNews.getNews(widget.name.toLowerCase());
    Categories = showCategoryNews.Categories;
    setState(() {
      _Loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            elevation: 0.0,
            title: Text(
              widget.name,
              style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            )),
        body: SingleChildScrollView(
          child: Column(
            children: [
              //return News Api in Categories
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemCount: Categories.length,
                  itemBuilder: (context, index) {
                    return ShowCategory(
                      image: Categories[index].urlToImage!,
                      description: Categories[index].description!,
                      titel: Categories[index].title!,
                      url: Categories[index].url!,
                    );
                  },
                ),
              )
            ],
          ),
        ));
  }
}

// ignore: must_be_immutable
class ShowCategory extends StatelessWidget {
  String image, description, titel, url;
  ShowCategory(
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
