part of 'pages.dart';

class MealDetails extends StatefulWidget {
  MealDetails({Key? key}) : super(key: key);

  @override
  State<MealDetails> createState() => _MealDetailsState();
}

class _MealDetailsState extends State<MealDetails> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as MealClass;

    List<Widget> getIngredientWidgets() {
      List<Widget> ingredientWidgets = [];
      args.ingredients.forEach((key, value) {
        print(key);
        print(value[0]);
        IngredientWidget(keyTitle: key, value: value);
        ingredientWidgets.add(IngredientWidget(keyTitle: key, value: value));
      });
      return ingredientWidgets;
    }

    // getIngredients();
    return Scaffold(
      appBar: AppBar(title: Text(args.name)),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(args.imageUrl),
              ),
            ),
          ),
          Column(
            children: getIngredientWidgets(),
          )
        ],
      ),
    );
  }
}

class IngredientWidget extends StatefulWidget {
  final keyTitle, value;
  IngredientWidget({Key? key, required this.keyTitle, required this.value})
      : super(key: key);

  @override
  State<IngredientWidget> createState() => _IngredientWidgetState();
}

class _IngredientWidgetState extends State<IngredientWidget> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
