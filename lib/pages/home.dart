// ignore_for_file: unnecessary_new

part of 'pages.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, User? user}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  void _onButtonTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget getHomeWidget(BuildContext context) {
    switch (_selectedIndex) {
      case 0:
        {
          print("home");
          return Stack(
            fit: StackFit.expand,
            children: [
              SwipeCardsWidget(),
              searchBarUI(context),
            ],
          );
        }
        break;

      case 1:
        {
          print("fav");
          return FavoriteWidget();
        }
        break;

      case 2:
        {
          print("orders");
          return Text("Orders");
        }
        break;

      default:
        {
          return ProfileWidget();
          // Column(
          //   children: [
          //     ElevatedButton(
          //       child: Text('logout'),
          //       onPressed: () async {
          //         await FirebaseAuth.instance.signOut();
          //         Navigator.pushReplacementNamed(context, "/login");
          //       },
          //     )
          //   ],
          // );
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text("Home")),
      body: getHomeWidget(context),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorite',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list_alt),
              label: 'Orders',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Profile',
            ),
          ],
          selectedItemColor: Colors.amber[800],
          currentIndex: _selectedIndex,
          onTap: _onButtonTapped,
          type: BottomNavigationBarType.fixed),
    );
  }
}

Widget searchBarUI(BuildContext context) {
  return FloatingSearchBar(
    onSubmitted: (query) => {
      Navigator.pushReplacementNamed(context, '/search', arguments: query),
    },
    margins: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
    hint: 'Nasi Goreng',
    openAxisAlignment: 0.0,
    axisAlignment: 0.0,
    scrollPadding: EdgeInsets.only(top: 16, bottom: 20),
    elevation: 4.0,
    physics: BouncingScrollPhysics(),
    onQueryChanged: (query) {
      print(query);
    },
    transitionCurve: Curves.easeInOut,
    transitionDuration: Duration(milliseconds: 500),
    transition: CircularFloatingSearchBarTransition(),
    debounceDelay: Duration(milliseconds: 500),
    actions: [
      FloatingSearchBarAction(
        showIfOpened: false,
        child: CircularButton(
          icon: Icon(Icons.search),
          onPressed: () {
            print('Places Pressed');
          },
        ),
      ),
      FloatingSearchBarAction.searchToClear(
        showIfClosed: false,
      ),
    ],
    builder: (context, transition) {
      var controller;
      int getlength() {
        if (currentUser!.history.length > 5) {
          return 5;
        } else {
          return currentUser!.history.length;
        }
      }

      return ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Material(
          color: Colors.white,
          child: Container(
              height: 200.0,
              color: Colors.white,
              child: currentUser!.history.isNotEmpty
                  ? new ListView(
                      scrollDirection: Axis.vertical,
                      children: new List.generate(
                          getlength(),
                          (index) => new ListTile(
                              title: Text(currentUser!.history.elementAt(
                                  currentUser!.history.length - index - 1)),
                              onTap: () => Navigator.pushReplacementNamed(
                                  context, '/search',
                                  arguments: currentUser!.history.elementAt(
                                      currentUser!.history.length -
                                          index -
                                          1)))),
                    )
                  : ListTile(
                      title: Text('no search History'),
                    )),
        ),
      );
    },
  );
}
