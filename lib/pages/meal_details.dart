part of 'pages.dart';

class MealDetails extends StatefulWidget {
  MealDetails({Key? key}) : super(key: key);

  @override
  State<MealDetails> createState() => _MealDetailsState();
}

class _MealDetailsState extends State<MealDetails> {
  void addMealToCart(MealClass meal) {
    bool exist = false;
    // if (cart.isNotEmpty) {
    for (var element in cart) {
      if (element.meal.id == meal.id) {
        element.count++;
        exist = true;
      }
    }
    // }
    if (!exist) {
      cart.add(MealCartClass(1, meal));
    }
  }

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(args.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
                child: SizedBox(
                  height: 250,
                  width: double.infinity,
                )),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: Column(
                children: getIngredientWidgets(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 25),
              child: ElevatedButton(
                onPressed: () {
                  // Navigator.pushNamed(context, "/shop_ingredients");
                  addMealToCart(args);
                  print(cart);
                },
                child: Text("Shop Ingredients"),
              ),
            )
          ],
        ),
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
            "\u2022 " + widget.value[index].toString().trim(),
            style: TextStyle(fontSize: 14),
          ),
          dense: true,
          visualDensity: VisualDensity(horizontal: 0, vertical: -4),
        ),
        // scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
      ),
    ]);
  }
}
