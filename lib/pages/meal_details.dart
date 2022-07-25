part of 'pages.dart';

class MealDetails extends StatefulWidget {
  MealDetails({Key? key}) : super(key: key);

  @override
  State<MealDetails> createState() => _MealDetailsState();
}

class _MealDetailsState extends State<MealDetails> {
  


  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as MealClass;


    return Scaffold(
      appBar: AppBar(title: Text(args.name)),
    );
  }
} 