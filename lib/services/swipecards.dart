part of 'services.dart';


Future<List<MealClass>> loadSwipeCardContent() async {
  QuerySnapshot<Map<String, dynamic>> data = await FirebaseFirestore.instance.collection("foods").get();
  List<MealClass> meals = [];
  
  for(QueryDocumentSnapshot<Map<String,dynamic>> doc in data.docs){
    var tags = (doc.data()['tags'] as List).map((x)=> x as String).toList();
    MealClass newMeal = MealClass(doc.id, doc.data()['image_url'], doc.data()['name'], tags);
    meals.add(newMeal);
  }
  return meals;
}
