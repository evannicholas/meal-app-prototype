part of 'services.dart';

List<MealClass> likedMeal = [];
List<MealClass> dislikedMeal = [];

Future<List<MealClass>> loadSwipeCardContent() async {
  await reloadUserData();
  QuerySnapshot<Map<String, dynamic>> data =
      await FirebaseFirestore.instance.collection("foods").get();
  List<MealClass> meals = [];

  for (QueryDocumentSnapshot<Map<String, dynamic>> doc in data.docs) {
    var tags = (doc.data()['tags'] as List).map((x) => x as String).toList();
    MealClass newMeal =
        MealClass(doc.id, doc.data()['image_url'], doc.data()['name'], tags, doc.data()['detail']);
    if (!currentUser!.likes.contains(newMeal.id) &&
        !currentUser!.dislikes.contains(newMeal.id)) {
      meals.add(newMeal);
    }
  }
  meals.shuffle();
  return meals;
}

int currentIndex = 0;
