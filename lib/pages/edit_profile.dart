part of 'pages.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool showPassword = true;

  final passController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final user = FirebaseAuth.instance.currentUser;
  @override
  void dispose() {
    passController.dispose();
    nameController.dispose();
    emailController.dispose();
    super.dispose();
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
                Text(
                  "Edit Profile",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                SizedBox(
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
                      child: Text(
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

                        Navigator.of(context).pop();
                      }, // edit the profile
                      color: Colors.blueAccent,
                      child: Text(
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
}
