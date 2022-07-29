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
  bool isloading = false;
  late MealClass currentMeal;
  void loadData() async {
    isloading = true;
    data = await loadSwipeCardContent();
    currentMeal = data![0];
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
            firestore.collection('users').doc(currentUser!.id).update({
              "dislikes": FieldValue.arrayUnion([data![i].id]),
            });
            dislikedMeal.add(data![i]);
            currentIndex = i + 1;
          },
          // superlikeAction: () {
          //   // _scaffoldKey.currentState?.showSnackBar(SnackBar(
          //   //   content: Text("Superliked ${_names[i]}"),
          //   //   duration: Duration(milliseconds: 500),
          //   // ));
          //   firestore.collection('users').doc(currentUser!.id).update({
          //     "likes": FieldValue.arrayUnion([data![i].id]),
          //   });
          //   print("Superliked ${data![i].name}");
          //   currentIndex = i + 1;
          // },
          onSlideUpdate: (SlideRegion? region) async {
            // print("Region $region");
          }));
      print("CARD ADDED");
      images.add(data![i].imageUrl);
    }
    setState(() {}); // refresh

    _matchEngine = MatchEngine(swipeItems: _swipeItems);
    print(_matchEngine);
    isloading = false;
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (!isloading)
        ? Column(children: [
            Expanded(
                child: LayoutBuilder(
              builder: (context, constraints) => Container(
                  child: _matchEngine != null
                      ? GestureDetector(
                          onTap: () {
                            print("Next page");
                            Navigator.pushNamed(context, '/meal_details',
                                arguments: currentMeal);
                          },
                          child: SwipeCards(
                            matchEngine: _matchEngine!,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                alignment: Alignment.bottomLeft,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(images[index]),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(30.0),
                                    bottomRight: Radius.circular(30.0),
                                  ),
                                ),
                                child: Text(
                                  _swipeItems[index].content.text,
                                  style: TextStyle(
                                    fontSize: 32,
                                    color: Colors.white,
                                    shadows: <Shadow>[
                                      Shadow(
                                        offset: Offset(0.0, 0.0),
                                        blurRadius: 10.0,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      ),
                                    ],
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
                              print(
                                  "item: ${item.content.text}, index: $index");
                              currentMeal = data![index];
                            },
                            upSwipeAllowed: false,
                            fillSpace: true,
                          ),
                        )
                      : SizedBox()),
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      _matchEngine!.currentItem?.nope();
                    },
                    child: Text("Nope")),
                // ElevatedButton(
                //     onPressed: () {
                //       _matchEngine!.currentItem?.superLike();
                //     },
                //     child: Text("Superlike")),
                ElevatedButton(
                    onPressed: () {
                      _matchEngine!.currentItem?.like();
                    },
                    child: Text("Like"))
              ],
            )
          ])
        : Text("Loading");
  }
}
