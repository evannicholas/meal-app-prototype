part of 'widgets.dart';

class SwipeCardsWidget extends StatefulWidget {
  SwipeCardsWidget({Key? key}) : super(key: key);

  @override
  State<SwipeCardsWidget> createState() => _SwipeCardsWidgetState();
}

class _SwipeCardsWidgetState extends State<SwipeCardsWidget> {
  List<SwipeItem> _swipeItems = <SwipeItem>[];
  MatchEngine? _matchEngine;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  List<MealClass>? data;
  List<String> images = [];
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  void loadData() async {
    data = await loadSwipeCardContent();
    for (int i = currentIndex; i < data!.length - 1; i++) {
      _swipeItems.add(SwipeItem(
          content: Content(text: data![i].name),
          likeAction: () { 
            // _scaffoldKey.currentState?.showSnackBar(SnackBar(
            //   content: Text("Liked ${_names[i]}"),
            //   duration: Duration(milliseconds: 500),
            // ));
            print("Liked ${data![i].name}");
            print("Liked ${i}");
            firestore.collection('users').doc(currentUser!.id).update({
          "likes": FieldValue.arrayUnion([data![i].id]),
});

            
            
            likedMeal.add(data![i]);
            currentIndex = i + 1;
          },
          nopeAction: () {
            // _scaffoldKey.currentState?.showSnackBar(SnackBar(
            //   content: Text("Nope ${_namesR[i]}"),
            //   duration: Duration(milliseconds: 500),
            // ));
            print("Nope ${data![i].name}");
            dislikedMeal.add(data![i]);
            currentIndex = i + 1;
          },
          superlikeAction: () {
            // _scaffoldKey.currentState?.showSnackBar(SnackBar(
            //   content: Text("Superliked ${_names[i]}"),
            //   duration: Duration(milliseconds: 500),
            // ));
            print("Superliked ${data![i].name}");
            currentIndex = i + 1;
          },
          onSlideUpdate: (SlideRegion? region) async {
            // print("Region $region");
          }));
      print("CARD ADDED");
      images.add(data![i].imageUrl);
    }
    setState(() {}); // refresh

    _matchEngine = MatchEngine(swipeItems: _swipeItems);
    print(_matchEngine);
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
          child: _matchEngine != null
              ? SwipeCards(
                  matchEngine: _matchEngine!,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      alignment: Alignment.bottomLeft,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(images[index]),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        _swipeItems[index].content.text,
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                        ),
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
                )
              : SizedBox()),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
              onPressed: () {
                _matchEngine!.currentItem?.nope();
              },
              child: Text("Nope")),
          ElevatedButton(
              onPressed: () {
                _matchEngine!.currentItem?.superLike();
              },
              child: Text("Superlike")),
          ElevatedButton(
              onPressed: () {
                _matchEngine!.currentItem?.like();
              },
              child: Text("Like"))
        ],
      )
    ]);
  }
}
