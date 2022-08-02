part of 'widgets.dart';

class ItemCarousel extends StatefulWidget {
  final List<MealClass> listOption;
  ItemCarousel({Key? key, required this.listOption}) : super(key: key);

  @override
  State<ItemCarousel> createState() => _ItemCarouselState();
}

class _ItemCarouselState extends State<ItemCarousel> {
  List<Widget> cards = [];
  Widget getCarouselWidget() {
    if (cards.length > 0) {
      return Container(
        height: 170.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: cards,
        ),
      );
    } else {
      return Text('loading');
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      cards = new List.generate(
          widget.listOption.length,
          (index) => new CustomCard(
                index: index,
                items: widget.listOption,
              ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return getCarouselWidget();
  }
}

class CustomCard extends StatelessWidget {
  final index;
  final items;
  CustomCard({Key? key, required this.index, required this.items})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        child: Column(
          children: [
            Container(
              width: 170,
              height: 115,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(items.elementAt(index).imageUrl),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
            ),
            Text(
              items.elementAt(index).name,
              style: TextStyle(fontSize: 18),
            )
          ],
        ),
        onTap: () {
          // print(listResep.elementAt(0).ingredients.length);
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => ResepPage(
          //       selectedResep: listResep[index],
          //     ),
          //   ),
          // );
        },
      ),
    );
  }
}
