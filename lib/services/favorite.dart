part of 'services.dart';



Future<UserModel> loadFavoriteContent() async {
  await reloadUserData();
  QuerySnapshot<Map<String, dynamic>> data =
      await FirebaseFirestore.instance.collection("users").get();
  UserModel user = UserModel("1","1","1",["1"],["1"]);

  for (QueryDocumentSnapshot<Map<String, dynamic>> doc in data.docs) {
    print(doc.id);
    print(currentUser!.id);
    if(currentUser!.id == doc.id){
      var likes = (doc.data()['likes'] as List).map((x) => x as String).toList();
      user = UserModel(doc.id, doc.data()['name'], doc.data()['email'], doc.data()['likes'], doc.data()['dislikes']);
    }
  
  }

  return user;
}