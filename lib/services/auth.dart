part of 'services.dart';

UserModel? currentUser;

Future<bool> loginAuth(String email, String password) async {
  bool result = false;
  try {
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection("users")
        .doc(credential.user!.uid)
        .get();
    final data = doc.data() as Map<String, dynamic>;
    // Map <String, dynamic> data = jsonEncode(doc.data());
    var likes = (data['likes'] as List).map((x) => x as String).toList();
    var dislikes = (data['dislikes'] as List).map((x) => x as String).toList();
    currentUser =
        UserModel(credential.user!.uid, data['name'], credential.user!.email!, likes, dislikes);
    result = true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  }
  return result;
}

Future<void> signUp(String name, String email, String password) async {
  UserCredential userCredential = await FirebaseAuth.instance
      .createUserWithEmailAndPassword(email: email, password: password);
  //Insert user to firestore
  await FirebaseFirestore.instance
      .collection("users")
      .doc(userCredential.user!.uid)
      .set({'name': name, 'likes': [], 'dislikes': []}).onError(
          (e, _) => print("Error writing document: $e"));
}

Future<void> autoLogin(User user) async {
  DocumentSnapshot doc =
      await FirebaseFirestore.instance.collection("users").doc(user.uid).get();
  final data = doc.data() as Map<String, dynamic>;
  // Map <String, dynamic> data = jsonEncode(doc.data());
  var likes = (data['likes'] as List).map((x) => x as String).toList();
  var dislikes = (data['dislikes'] as List).map((x) => x as String).toList();
  print("============================");
  //  print(likes);
  //  print(user.uid);
  //  print(data['name']);
  //  print(data['likes'] == likes);
  //  print(data['dislikes'].toString() == dislikes);
  print("============================");
  currentUser = UserModel(user.uid, data['name'], user.email!, likes, dislikes);
}

Future<void> reloadUserData() async {
  DocumentSnapshot doc = await FirebaseFirestore.instance
      .collection("users")
      .doc(currentUser!.id)
      .get();
  final data = doc.data() as Map<String, dynamic>;
  // Map <String, dynamic> data = jsonEncode(doc.data());
  var likes = (data['likes'] as List).map((x) => x as String).toList();
  var dislikes = (data['dislikes'] as List).map((x) => x as String).toList();
  currentUser = UserModel(
      currentUser!.id, data['name'], currentUser!.email, likes, dislikes);
}









// class AuthenticateLogin{
  
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

//   AuthenticateLogin(_firebaseAuth);

//   Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

//   Future<String?> signIn({required String email, required String  password}) async {

//     try {
//       await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
//       return "Signed in";
//     } on FirebaseAuthException catch (e) {
//       return e.message;
//     }
//   }
//   Future<String?> signUp({required String email, required String  password}) async {

//     try {
//       await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
//       return "Signed up";
//     } on FirebaseAuthException catch (e) {
//       return e.message;
//     }
//   }

 
// }