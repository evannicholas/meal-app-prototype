part of 'widgets.dart';

class SwipeCardsWidget extends StatefulWidget {
  SwipeCardsWidget({Key? key}) : super(key: key);

  @override
  State<SwipeCardsWidget> createState() => _SwipeCardsWidgetState();
}

class _SwipeCardsWidgetState extends State<SwipeCardsWidget> {
  List<SwipeItem> _swipeItems = <SwipeItem>[];
  late MatchEngine _matchEngine;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  List<String> _names = ["Red", "Blue", "Green", "Yellow", "Orange"];
  List<Color> _colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange
  ];

  void loadData() async {
    List<MealClass> data = await loadSwipeCardContent();
    
    for (int i = 0; i < data.length; i++) {
      _swipeItems.add(SwipeItem(
          content: Content(text: data[i].name, color: _colors[i]),
          likeAction: () {
            // _scaffoldKey.currentState?.showSnackBar(SnackBar(
            //   content: Text("Liked ${_names[i]}"),
            //   duration: Duration(milliseconds: 500),
            // ));
            print("Liked ${_names[i]}");
          },
          nopeAction: () {
            // _scaffoldKey.currentState?.showSnackBar(SnackBar(
            //   content: Text("Nope ${_names[i]}"),
            //   duration: Duration(milliseconds: 500),
            // ));
            print("Nope ${_names[i]}");
          },
          superlikeAction: () {
            // _scaffoldKey.currentState?.showSnackBar(SnackBar(
            //   content: Text("Superliked ${_names[i]}"),
            //   duration: Duration(milliseconds: 500),
            // ));
            print("Superliked ${_names[i]}");
          },
          onSlideUpdate: (SlideRegion? region) async {
            // print("Region $region");
          }));
    }

    _matchEngine = MatchEngine(swipeItems: _swipeItems);
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        height: 550,
        child: SwipeCards(
          matchEngine: _matchEngine,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              alignment: Alignment.center,
              color: _swipeItems[index].content.color,
              child: Text(
                _swipeItems[index].content.text,
                style: TextStyle(fontSize: 100),
              ),
            );
          },
          onStackFinished: () {
            // _scaffoldKey.currentState.showSnackBar(SnackBar(
            //   content: Text("Stack Finished"),
            //   duration: Duration(milliseconds: 500),
            // ));
            print("Stack finish");
          },
          itemChanged: (SwipeItem item, int index) {
            print("item: ${item.content.text}, index: $index");
          },
          upSwipeAllowed: true,
          fillSpace: true,
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
              onPressed: () {
                _matchEngine.currentItem?.nope();
              },
              child: Text("Nope")),
          ElevatedButton(
              onPressed: () {
                _matchEngine.currentItem?.superLike();
              },
              child: Text("Superlike")),
          ElevatedButton(
              onPressed: () {
                _matchEngine.currentItem?.like();
              },
              child: Text("Like"))
        ],
      )
    ]);
  }
}
