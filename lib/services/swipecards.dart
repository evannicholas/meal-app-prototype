part of 'services.dart';

List<MealClass> likedMeal = [];
List<MealClass> dislikedMeal = [];
List<MealClass> allMeal = [];

Future<void> loadSwipeCardContent() async {
  await reloadUserData();
  allMeal.clear();
  QuerySnapshot<Map<String, dynamic>> data =
      await FirebaseFirestore.instance.collection("foods").get();

  for (QueryDocumentSnapshot<Map<String, dynamic>> doc in data.docs) {
    var tags = (doc.data()['tags'] as List).map((x) => x as String).toList();
    MealClass newMeal = MealClass(doc.id, doc.data()['image_url'],
        doc.data()['name'], tags, doc.data()['detail']);
    if (!currentUser!.likes.contains(newMeal.id) &&
        !currentUser!.dislikes.contains(newMeal.id)) {
      allMeal.add(newMeal);
    }
  }
  allMeal.shuffle();
}

int currentIndex = 0;
