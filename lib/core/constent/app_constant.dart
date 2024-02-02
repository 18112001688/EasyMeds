import 'package:medcs/core/utlity/images.dart';
import 'package:medcs/features/home/data/models/category_model.dart';

class AppConstent {
  static List<CategoryModel> categoriesList = [
    CategoryModel(
      categoryName: 'beauty',
      id: 'beauty',
      image: AppImages.beauty,
    ),
    CategoryModel(
      categoryName: 'basic',
      id: 'basic',
      image: AppImages.basic,
    ),
    CategoryModel(
      categoryName: 'Supplements',
      id: 'Supplements',
      image: AppImages.vitmin,
    ),
    CategoryModel(
      categoryName: 'Lifestyle',
      id: 'Lifestyle',
      image: AppImages.lifeStyle,
    ),
    CategoryModel(
      categoryName: 'Health',
      id: 'Health',
      image: AppImages.health,
    ),
    CategoryModel(
      categoryName: 'Family',
      id: 'Family',
      image: AppImages.family,
    ),
  ];
}
