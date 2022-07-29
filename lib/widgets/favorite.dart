part of 'widgets.dart';

class FavoriteWidget extends StatefulWidget {
  FavoriteWidget({Key? key}) : super(key: key);

  @override
  State<FavoriteWidget> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoriteWidget> {
  List<MealClass>? favoriteMeals;

  void getFavorites() async {
    favoriteMeals = await loadFavoriteContents();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    getFavorites();
    super.initState();
  }

  List<Widget> getFavoriteMealCards(){
    List<Widget> mealCards = [];

    for(MealClass meal in favoriteMeals!){
      mealCards.add(FavoriteMealCard(mealData: meal));
    }


    return mealCards;
  }


  @override
  Widget build(BuildContext context) {
    return favoriteMeals != null ? GridView.count(
      // Create a grid with 2 columns. If you change the scrollDirection to
      // horizontal, this produces 2 rows.
      crossAxisCount: 2,
      // Generate 100 widgets that display their index in the List.
      children: getFavoriteMealCards(),
    ) : Text("loading");
  }
}

class FavoriteMealCard extends StatefulWidget {
  final MealClass mealData;
  FavoriteMealCard({Key? key, required this.mealData}) : super(key: key);
  

  @override
  State<FavoriteMealCard> createState() => _FavoriteMealCardState();
}

class _FavoriteMealCardState extends State<FavoriteMealCard> {
  @override
  Widget build(BuildContext context) {
    return Text(widget.mealData.name);
  }
}