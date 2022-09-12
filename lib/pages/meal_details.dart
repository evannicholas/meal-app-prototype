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
    int itemQuantity = 0;

    List<Widget> getIngredientWidgets() {
      List<Widget> ingredientWidgets = [];
      args.ingredients.forEach((key, value) {
        IngredientWidget(keyTitle: key, value: value);
        ingredientWidgets.add(IngredientWidget(keyTitle: key, value: value));
      });
      return ingredientWidgets;
    }

    void getItemQuantityFromCart() {
      // Grab item quantitiy (Reactive)
      for (var item in cart) {
        if (args.id == item['meal']) {
          setState(() {
            itemQuantity = item['count'];
            print("setting state");
          });
        }
      }
    }

    @override
    void initState() {
      super.initState();
      loadCart();
      getItemQuantityFromCart();
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
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(args.details),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 25),
              child: itemQuantity == 0
                  ? ElevatedButton(
                      onPressed: () {
                        // Navigator.pushNamed(context, "/shop_ingredients");
                        addMealToCart(args);
                        print(cart);
                        getItemQuantityFromCart();
                      },
                      child: Text("Add to Cart"),
                    )
                  : Row(
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              addMealToCart(args);
                              print(cart);
                              loadCart();
                              getItemQuantityFromCart();
                            },
                            child: Icon(Icons.remove)),
                        Text(itemQuantity.toString()),
                        ElevatedButton(
                            onPressed: () {
                              addMealToCart(args);
                              print(cart);
                              loadCart();
                              getItemQuantityFromCart();
                            },
                            child: Icon(Icons.add))
                      ],
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
