part of 'services.dart';

String currentUser = "";

Future<bool> loginAuth(String email, String password) async {
  bool result = false;
  try {
    final credential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    currentUser = credential.user!.email!;
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

void setupAuthStateChanges(){
 
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