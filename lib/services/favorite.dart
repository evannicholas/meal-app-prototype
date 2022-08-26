part of 'services.dart';

Future<List<MealClass>> loadFavoriteContents() async {
  await reloadUserData();

  List<MealClass> favorites = [];

  for (String mealID in currentUser!.likes) {
    var doc = await FirebaseFirestore.instance.collection("foods").doc(mealID).get();
    
    if(doc.data() != null){
      var tags = (doc.data()!['tags'] as List).map((x) => x as String).toList();
      MealClass dummyMeal = MealClass(doc.id, doc.data()!['image_url'],doc.data()!['name'], tags, doc.data()!['detail'], doc.data()!['ingredients']);
      favorites.add(dummyMeal);
    }

  }

  return favorites;
}
