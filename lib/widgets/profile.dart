part of 'widgets.dart';

class ProfileWidget extends StatefulWidget {
  ProfileWidget({Key? key}) : super(key: key);
  ProfileWidgetState createState() => ProfileWidgetState();
}

class ProfileWidgetState extends State<ProfileWidget> {
  final String imageLink =
      "https://blog.texasbar.com/files/2011/12/housto-bankruptcy-attorney-adam-schachter1.jpg";

  var _context = null;
  var _like, _dislike = null;

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
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    _context = context;

    return SingleChildScrollView(
        child: Center(
            child: Column(children: <Widget>[
      Stack(
        children: [
          imageBuild(),
          Positioned(
              bottom: 0,
              right: 4,
              child:
                  buildEditIcon(Theme.of(context).colorScheme.primary, false))
        ],
      ),
      displayInformation()
    ])));
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
        Padding(
            padding: EdgeInsets.all(16.0),
            child: Text("Username: ${currentUser!.name}")),
        Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text("Email: ${currentUser!.email}")),
        Padding(padding: EdgeInsets.all(16.0), child: Text("Likes: $_like")),
        Padding(
            padding: EdgeInsets.all(16.0), child: Text("Dislikes: $_dislike")),
      ],
    );
  }

  Widget imageBuild() {
    final img = NetworkImage(imageLink);

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: img,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          child: InkWell(
            onTap: () {
              Navigator.pushNamed(context ,'/edit_profile');
            }
          ),
        ),
      ),
    );
  }
}
