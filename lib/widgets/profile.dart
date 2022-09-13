part of 'widgets.dart';

class ProfileWidget extends StatefulWidget {
  ProfileWidget({Key? key}) : super(key: key);
  ProfileWidgetState createState() => ProfileWidgetState();
}

class ProfileWidgetState extends State<ProfileWidget> {
  String _imageLink = "https://cdn-icons-png.flaticon.com/512/1946/1946429.png";
  final user = FirebaseAuth.instance.currentUser;
  var _context = null;
  var _like, _dislike, _name, _email = null;

  @override
  void initState() {
    assignLikeAndDislike();
    super.initState();
  }

  // User? _user = FirebaseAuth.instance.currentUser;
  void assignLikeAndDislike() {
    setState(() {
      _like = currentUser!.likes.length;
      _dislike = currentUser!.dislikes.length;
      _name = currentUser!.name;
      _email = currentUser!.email;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    _context = context;

    return SingleChildScrollView(
        child: Center(
            child: Column(children: <Widget>[
      const SizedBox(
        height: 35,
      ),
      Stack(
        children: [
          imageBuild(),
          Positioned(
              bottom: 0,
              right: 4,
              child: InkWell(
                  child: Container(
                      child: buildEditIcon(
                          Theme.of(context).colorScheme.primary, false)),
                  onTap: () {
                    _editProfile(context);
                  }))
        ],
      ),
      displayInformation()
    ])));
  }

  Future<void> _editProfile(BuildContext context) async {
    final result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => const EditProfile()));
    print("this is $result");
    if (result != null) {
      setState(() {
        print(result.toString());
        _imageLink = result.toString();
      });
    }
  }

  Widget buildEditIcon(Color color, bool isEdit) => buildCircle(
        color: Colors.white,
        all: 3,
        child: buildCircle(
          color: color,
          all: 8,
          child: Icon(
            isEdit ? Icons.add_a_photo : Icons.edit,
            color: Colors.white,
            size: 20,
          ),
        ),
      );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );

  Widget displayInformation() {
    setState(() {
      assignLikeAndDislike();
    });
    return Column(
      children: <Widget>[
        Padding(padding: EdgeInsets.all(16.0), child: Text("Username: $_name")),
        Padding(
            padding: const EdgeInsets.all(16.0), child: Text("Email: $_email")),
        Padding(padding: EdgeInsets.all(16.0), child: Text("Likes: $_like")),
        Padding(
            padding: EdgeInsets.all(16.0), child: Text("Dislikes: $_dislike")),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
              child: Text("Log Out"),
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 6, 65, 167),
                shape: const BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
              ),
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, "/login");
              }),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
              child: Text("update address"),
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 42, 201, 2),
                shape: const BeveledRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
              ),
              onPressed: () async {
                Navigator.pushNamed(context, "/set_location");
              }),
        )
      ],
    );
  }

  Widget imageBuild() {
    final img = NetworkImage(_imageLink);
    print("this is $_imageLink");
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: img,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          child: InkWell(onTap: () {
            _editProfile(context);
          }),
        ),
      ),
    );
  }
}
