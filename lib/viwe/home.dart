import 'dart:async';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:newsday1/data/Silder_Category.dart';
import 'package:newsday1/data/aritcles_news_api.dart';
import 'package:newsday1/data/data_category.dart';
import 'package:newsday1/model/Silder_model.dart';
import 'package:newsday1/model/aritcles_model.dart';
import 'package:newsday1/model/model_category.dart';
import 'package:newsday1/viwe/all_news.dart';
import 'package:newsday1/viwe/aritacle_viwe.dart';
import 'package:newsday1/viwe/category_news.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _Loading = true;
  List<CategoryModel> categories = [];
  List<SilderModel> silders = [];
  List<AritcleModel> articles = [];

  @override
  void initState() {
    Timer(Duration(minutes: 1), () {
      categories = getCategories();
      getsilder();
      getNews();
    });

    super.initState();
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      _Loading = false;
    });
  }

  getsilder() async {
    silder newsClass = silder();
    await newsClass.getsilder();
    silders = newsClass.silders;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "News ",
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Day",
              style: TextStyle(
                fontSize: 18,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: _Loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Container(
                    height: 70,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return CategoryTitel(
                            ImageUrl: categories[index].ImageUrl,
                            CategoryName: categories[index].CategoryName);
                      },
                    ),
                  ),
                  //Text viweAll and BrackingNews!
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "BrackingNews!",
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AllNews(news: "NewsDay")));
                              },
                              child: Text(
                                "ViweAll",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.orangeAccent,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ])),
                  //CarouselSlider.bulider retrun Home page
                  CarouselSlider.builder(
                      itemCount: silders.length,
                      itemBuilder: (context, index, realIndex) {
                        String? image = silders[index].urlToImage!;
                        String? titel = silders[index].title!;
                        return buildimage(image, index, titel);
                      },
                      options: CarouselOptions(
                        scrollDirection: Axis.horizontal,
                        height: 200,
                        viewportFraction: 1,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                        onPageChanged: (index, reason) {
                          setState(() {});
                        },
                      )),
                  //CarouselSlider.bulider End
                  //Text viweAll
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Trending News!",
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AllNews(news: "NewsDay")));
                              },
                              child: Text(
                                "ViweAll",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.orangeAccent,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ])),
                  //  صور غير موجوده
                  //NewsTrieding

                  //  صور غير موجوده
                  const SizedBox(
                    height: 10.0,
                  ),
                  //return News Api in Home page
                  Container(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: articles.length,
                      itemBuilder: (context, index) {
                        return BolgTitel(
                            url: articles[index].url!,
                            Imageurl: articles[index].urlToImage!,
                            title: articles[index].title!,
                            description: articles[index].description!);
                      },
                    ),
                  )
                ])),
    );
  }

  //CarouselSlider.bulider
  Widget buildimage(String image, int index, String titel) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Stack(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: image,
              height: 250,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: 250,
            margin: const EdgeInsets.only(top: 130.0),
            width: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30)),
            ),
            child: Text(
              titel,
              maxLines: 2,
              style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
          )
        ]),
      );
}
//CarouselSlider.bulider

//get Categories
class CategoryTitel extends StatelessWidget {
  // ignore: non_constant_identifier_names
  final String ImageUrl, CategoryName;
  // ignore: use_key_in_widget_constructors
  const CategoryTitel({required this.ImageUrl, required this.CategoryName});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryNews(
                      name: CategoryName,
                    )));
      },
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Stack(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                ImageUrl,
                width: 120,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Text(
                CategoryName,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ])),
    );
  }
}
// End get Categories

//Strart get News Api
// ignore: must_be_immutable
class BolgTitel extends StatelessWidget {
  String Imageurl, title, description, url;
  BolgTitel(
      {required this.Imageurl,
      required this.title,
      required this.description,
      required this.url});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Aritcleviwe(blogUrl: url)));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Material(
            elevation: 3.0,
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 3.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: Imageurl,
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 1.7,
                        child: Text(
                          title,
                          maxLines: 2,
                          style: const TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 1.7,
                        child: Text(
                          description,
                          maxLines: 3,
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: Colors.black45,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
//End get News Api