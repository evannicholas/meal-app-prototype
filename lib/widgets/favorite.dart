part of 'widgets.dart';

class FavoriteWidget extends StatefulWidget {
  FavoriteWidget({Key? key}) : super(key: key);

  @override
  State<FavoriteWidget> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoriteWidget> {

  UserModel? user;

  void getUserData() async{
    user = await loadFavoriteContent();
    
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Favorite")),
      body:Container(
        
      ),

      
    );
  }
}