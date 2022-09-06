part of 'services.dart';

// List<MealCartClass> cart = [];
List<Map<String,dynamic>> cart = [];

void addMealToCart(MealClass meal) {
  bool exist = false;

  for (var element in cart) {
    if (element['meal'].id == meal.id) {
      element['count'] = element['count'] + 1;
      exist = true;
    }
  }
    
  if (!exist) {
      cart.add({'meal': meal.id, 'count': 1});
  }
  
  var cartMap = {
    'cart':cart
  };
  firestore.collection("users").doc(currentUser!.id).update(cartMap);
  

}

void loadCart(){

}