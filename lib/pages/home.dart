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

  Widget getHomeWidget() {
    switch (_selectedIndex) {
      case 0:
        {
          print("home");
          return Stack(
            fit: StackFit.expand,
            children: [
              SwipeCardsWidget(),
              searchBarUI(),
            ],
          );
        }
        break;

      case 1:
        {
          print("fav");
          return Text("Favorite");
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
          return Column(
            children: [
              ElevatedButton(
                child: Text('logout'),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacementNamed(context, "/login");
                },
              )
            ],
          );
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text("Home")),
      body: getHomeWidget(),
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

Widget searchBarUI() {
  return FloatingSearchBar(
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
      return ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Material(
          color: Colors.white,
          child: Container(
            height: 200.0,
            color: Colors.white,
            child: Column(
              children: [
                ListTile(
                  title: Text('History'),
                  subtitle: Text('User History'),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
