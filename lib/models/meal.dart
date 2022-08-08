part of 'models.dart';

class MealClass {
  String id, imageUrl, name, details;
  Map ingredients;
  List<String> tags;

  MealClass(this.id, this.imageUrl, this.name, this.tags, this.details, this.ingredients);
}
