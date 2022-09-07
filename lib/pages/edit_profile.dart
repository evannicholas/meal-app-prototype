part of 'pages.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool showPassword = true;
  File? _pickedImg = File('');
  bool _statusImage = false;
  String _linkPic = '';

  var passController = TextEditingController();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;

  @override
  void dispose() {
    passController.dispose();
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (!user!.isAnonymous) {
      nameController = new TextEditingController(text: user!.displayName);
      emailController = new TextEditingController(text: user!.email);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          titleSpacing: 3.0,
          elevation: 1,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.blueAccent),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Container(
          padding: EdgeInsets.only(left: 15, top: 25, right: 16),
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: ListView(
              children: [
                const Text(
                  "Edit Profile",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 35,
                ),
                Center(child: widgetImage()),
                const SizedBox(
                  height: 35,
                ),
                buildTextField(
                    "Full Name", user?.displayName, false, nameController),
                buildTextField("E-mail", user?.email, false, emailController),
                buildTextField("Password", "*********", true, passController),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2,
                            color: Colors.black),
                      ),
                    ),
                    RaisedButton(
                      onPressed: () {
                        if (passController.text.isNotEmpty)
                          _changePassword(passController.text);
                        if (nameController.text.isNotEmpty)
                          _changeUsername(nameController.text);
                        if (emailController.text.isNotEmpty)
                          _changeEmail(emailController.text);

                        Navigator.pop(context, _linkPic);
                      }, // edit the profile
                      color: Colors.blueAccent,
                      child: const Text(
                        "Save Changes",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2,
                            color: Colors.white),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }

  _loadPickerImg(ImageSource src) async {
    XFile? pickedImg = await ImagePicker().pickImage(source: src);
    if (pickedImg != null) {
      _cropImage(File(pickedImg.path));
    }

    Navigator.pop(context);
  }

  _cropImage(File file) async {
    CroppedFile? croppedImg = await ImageCropper().cropImage(
      sourcePath: file.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.blueAccent,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    );

    if (croppedImg != null) {
      setState(() {
        _pickedImg = File(croppedImg.path);
        _statusImage = true;
        _uploadFile(File(croppedImg.path)).toString();
      });
    }
  }

  Future<void> _uploadFile(File file) async {
    print(user!.uid);
    Reference ref =
        FirebaseStorage.instance.ref().child("user/profile/${user!.uid}");

    UploadTask uploadTask = ref.putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask;

    String profilePicLink = await taskSnapshot.ref.getDownloadURL();
    setState(() {
      _linkPic = profilePicLink;
      print("this is the result now $_linkPic");
    });
  }

  void _assignImageOption(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: const Text("Pick from Gallery"),
                    onTap: () {
                      _loadPickerImg(ImageSource.gallery);
                    },
                  ),
                  ListTile(
                    title: const Text("Take a Picture"),
                    onTap: () {
                      _loadPickerImg(ImageSource.camera);
                    },
                  )
                ],
              ),
            ));
  }

  Widget buildTextField(String label, String? placeholder, bool isPasswordType,
      TextEditingController controllerField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        controller: controllerField,
        obscureText: isPasswordType ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordType
                ? IconButton(
                    icon: Icon(Icons.remove_red_eye),
                    color: Colors.grey,
                    onPressed: (() {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    }),
                  )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: label,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
      ),
    );
  }

  void _changePassword(String password) async {
    //Create an instance of the current user.
    final currentUser = await FirebaseAuth.instance.currentUser;

    setState((() {
      currentUser!.updatePassword(password).then((_) {
        print("Successfully changed password");
      }).catchError((err) {
        print("Error , Password can't be changed.");
      });
    }));
  }

  void _changeUsername(String username) async {
    final currentUser = await FirebaseAuth.instance.currentUser;

    setState((() {
      currentUser!.updateDisplayName(username).then((_) {
        print("Successfully changed username");
      }).catchError((err) {
        print("Error , Username can't be changed.");
      });
    }));
  }

  void _changeEmail(String email) async {
    final currentUser = await FirebaseAuth.instance.currentUser;

    setState(() {
      currentUser!.updateEmail(email).then((_) {
        print("Successfully changed email");
      }).catchError((err) {
        print("Error , Email can't be changed.");
      });
    });
  }

  Widget widgetImage() {
    return Stack(
      children: [
        imageBuild(),
        Positioned(
            bottom: 0,
            right: 4,
            child: InkWell(
              child: Container(
                child:
                    buildEditIcon(Theme.of(context).colorScheme.primary, false),
              ),
              onTap: () {
                _assignImageOption(context);
                // what will happen when we tap edit button in img
              },
            ))
      ],
    );
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

  Widget imageBuild() {
    String url = "https://cdn-icons-png.flaticon.com/512/1946/1946429.png";
    final defaultImg = NetworkImage(url);
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: _statusImage
              ? FileImage(_pickedImg!)
              : defaultImg as ImageProvider,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          child: InkWell(onTap: () {
            _assignImageOption(context);
            //what happen when tapping the img
          }),
        ),
      ),
    );
  }
}
