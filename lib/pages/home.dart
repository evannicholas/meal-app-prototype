part of 'pages.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, User? user}) : super(key: key);


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  void _onButtonTapped(int index){
    setState((){
      _selectedIndex = index;
    });
  }

  Widget getHomeWidget() {
    switch (_selectedIndex) {
      case 0:
        {
          print("home");
          return SwipeCardsWidget();
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
                onPressed: () async{
                  
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacementNamed(context, "/login");

                }
              ,)
            ],
          );
        }
        break;
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        type: BottomNavigationBarType.fixed
        ),
        
      
    );

   
  }
}