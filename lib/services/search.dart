part of 'services.dart';

List<MealClass> searchResult = [];

void searchEngine(String query) {
  print('masuk search engine');
  print('Query = ' + query);
  searchResult.clear();
  for (var element in allMeal) {
    final nameComparison = query.similarityTo(element.name);
    // if (query == element.name) {
    //   print(query);
    // }
    // print(element.name);
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
}
