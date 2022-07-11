part of 'pages.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        autoLogin(user);
        Navigator.pushReplacementNamed(context, '/home');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Column(children: [
        TextField(
          controller: emailController,
          decoration: InputDecoration(labelText: "Email"),
        ),
        TextField(
          controller: passwordController,
          decoration: InputDecoration(labelText: "Password"),
          obscureText: true,
        ),
        Row(
          children: [
            ElevatedButton(
                onPressed: () async {
                  bool result = await loginAuth(
                      emailController.text, passwordController.text);
                  if (result) {
                    Navigator.pushReplacementNamed(context, '/home');
                  }
                },
                child: Text("Login")),
            ElevatedButton(onPressed: () {
              Navigator.pushNamed(context, '/register');
            }, child: Text("Register"))
          ],
        ),
      ]),
    );
  }
}
