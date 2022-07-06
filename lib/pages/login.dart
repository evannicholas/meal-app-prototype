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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Column(children: [
      TextField(controller: emailController, decoration: InputDecoration(labelText: "Email"),),
      TextField(controller: passwordController,decoration: InputDecoration(labelText: "Password"), obscureText: true,),
      Row(children: [
        ElevatedButton(onPressed: () async {
           await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text.trim(), 
            password: passwordController.text.trim()
          );

        }, child: Text("Login")),
        ElevatedButton(onPressed: (){

        }, child: Text("Register"))
        
        ],
        ),
      
      ]),
      

    );
  }
}