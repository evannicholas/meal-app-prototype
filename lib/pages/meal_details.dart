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
        print("========");
        print(key);
        print(value);
        print("========");
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
            child: Image.network(args.imageUrl),
          ),
          Column(
            children: getIngredientWidgets(),
          ),
          ElevatedButton(
            onPressed:(){
              Navigator.pushNamed(context, "/shop_ingredients");
            } , 
            child: Text("Shop Ingredients"),)
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
    return Column(children: [
      Text(
        widget.keyTitle.toString(),
        style: TextStyle(fontSize: 18),
      ),
      ListView.builder(
        itemCount: widget.value.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(
            "\u2022 "+widget.value[index].toString().trim(),
            style: TextStyle(fontSize: 14),
          ),
          dense: true,
          visualDensity: VisualDensity(horizontal: 0, vertical: -4),
        ),
        
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
      ),
    ]);
  }
}