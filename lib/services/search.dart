part of 'services.dart';

List<MealClass> searchResult = [];
List<String> userSearchHistory = [];

FirebaseFirestore firestore = FirebaseFirestore.instance;
void searchEngine(String query) {
  print('masuk search engine');
  print('Query = ' + query);
  searchResult.clear();

  userSearchHistory.add(query);

  for (var element in allMeal) {
    final nameComparison = query.similarityTo(element.name);
    // if (query == element.name) {
    //   print(query);
    // }
    // print(element.name);

    firestore.collection('users').doc(currentUser!.id).update({
      "history": FieldValue.arrayUnion([query]),
    });

    if (nameComparison > 0.5) {
      print('name = ' + element.name + ' = ' + nameComparison.toString());
      searchResult.add(element);
      continue;
    }
    for (var tag in element.tags) {
      final tagComparison = query.similarityTo(tag);
      if (tagComparison > 0.5) {
        print('tag = ' + tag + ' = ' + tagComparison.toString());
        searchResult.add(element);
      }
    }
  }
  reloadUserData();
}

void clearHistory() {
  firestore
      .collection('users')
      .doc(currentUser!.id)
      .update({"history": FieldValue.arrayRemove(currentUser!.history)});
  reloadUserData();
}
// Future<List<MealClass>> loadSearchHistory() async {
//   await reloadUserData();

//   List<MealClass> searchHistory = [];

//   for (String element in currentUser!.history) {
//     var doc = await FirebaseFirestore.instance
//         .collection("users")
//         .doc(currentUser!.id)
//         .collection("history")
//         .get();

//     searchHistory.add(dummyMeal);
//   }

//   return searchHistory;
// }

// Future<void> loadSearchHistory() async {
//   await reloadUserData();
//   userSearchHistory.clear();
//   QuerySnapshot<Map<String, dynamic>> data =
//       await FirebaseFirestore.instance.collection("users").doc(currentUser!.id);

//   for (QueryDocumentSnapshot<Map<String, dynamic>> doc in data.docs) {
//     var tags = (doc.data()['tags'] as List).map((x) => x as String).toList();
//     MealClass newMeal = MealClass(doc.id, doc.data()['image_url'],
//         doc.data()['name'], tags, doc.data()['detail']);
//     if (!currentUser!.likes.contains(newMeal.id) &&
//         !currentUser!.dislikes.contains(newMeal.id)) {
//       allMeal.add(newMeal);
//     }
//   }
//   allMeal.shuffle();
// }