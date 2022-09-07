// part of 'pages.dart';

// class CartPage extends StatefulWidget {
//   const CartPage({super.key});

//   @override
//   State<CartPage> createState() => _CartPageState();
// }

// class _CartPageState extends State<CartPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Your Cart')),
//       body: ListView.builder(
//           padding: const EdgeInsets.all(8),
//           itemCount: cart.length,
//           itemBuilder: (BuildContext context, int index) {
//             return ListTile(
//               leading: ConstrainedBox(
//                 constraints: BoxConstraints(
//                   minWidth: 100,
//                   minHeight: 100,
//                   maxWidth: 100,
//                   maxHeight: 100,
//                 ),
//                 child: Image.network(cart.elementAt(index).meal.imageUrl,
//                     fit: BoxFit.cover),
//               ),
//               title: Text(cart.elementAt(index).meal.name),
//               subtitle:
//                   Text('jumlah: ' + cart.elementAt(index).count.toString()),
              
//             );
//           }),
//     );
//   }
// }
