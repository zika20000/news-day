// ignore: unused_import
import 'package:flutter/foundation.dart';
import 'package:newsday1/model/model_category.dart';

List<CategoryModel> getCategories() {
  List<CategoryModel> categories = [];
  CategoryModel categoryModel = new CategoryModel();
  categoryModel = new CategoryModel();
  categoryModel.CategoryName = "sport";
  categoryModel.ImageUrl =
      "https://images.pexels.com/photos/863988/pexels-photo-863988.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1";
  categories.add(categoryModel);
  categoryModel = new CategoryModel();
  categoryModel.CategoryName = "technology";
  categoryModel.ImageUrl =
      "https://images.pexels.com/photos/356056/pexels-photo-356056.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1";
  categories.add(categoryModel);
  categoryModel = new CategoryModel();
  categoryModel.CategoryName = "General";
  categoryModel.ImageUrl =
      "https://images.pexels.com/photos/14911691/pexels-photo-14911691.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1";
  categories.add(categoryModel);
  categoryModel = new CategoryModel();
  categoryModel.CategoryName = "Business ";
  categoryModel.ImageUrl =
      "https://images.pexels.com/photos/264507/pexels-photo-264507.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1";
  categories.add(categoryModel);
  categoryModel = new CategoryModel();
  categoryModel.CategoryName = "Health";
  categoryModel.ImageUrl =
      "https://images.pexels.com/photos/221210/pexels-photo-221210.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1";
  categories.add(categoryModel);
  categoryModel = new CategoryModel();
  categoryModel.CategoryName = "Science";
  categoryModel.ImageUrl =
      "https://images.pexels.com/photos/41006/satellite-soyuz-spaceship-space-station-41006.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1";
  categories.add(categoryModel);
  categoryModel = new CategoryModel();

  return categories;
}
