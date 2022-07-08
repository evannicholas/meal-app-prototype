part of 'pages.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, User? user}) : super(key: key);


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  late User user;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(currentUser)),
      body: ElevatedButton(child: Text('logout'),
      onPressed: () async{
        await FirebaseAuth.instance.signOut();
        Navigator.pushReplacementNamed(context, "/login");

      },)
    );
  }
}