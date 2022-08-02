part of 'pages.dart';

class SearchPage extends StatefulWidget {
  // final String query;
  SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    final String query = ModalRoute.of(context)!.settings.arguments as String;
    searchEngine(query);
    // return Scaffold(
    //   appBar: AppBar(title: Text('Result of ' + query)),
    //   body: Stack(
    //     fit: StackFit.expand,
    //     children: [
    //       Padding(
    //         padding: EdgeInsets.only(top: 40),
    //         child: Container(child: ItemCarousel()),
    //       ),
    //       searchBarUI(context),
    //     ],
    //   ),
    // );
    return MaterialApp(
        // Remove the debug banner
        debugShowCheckedModeBanner: false,
        title: 'search Result of ',
        theme: ThemeData(),
        home: Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                floating: true,
                pinned: true,
                snap: false,
                centerTitle: false,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                title: Text('Search result of ' + query),
                bottom: AppBar(
                  toolbarHeight: 70,
                  title: Center(
                    child: TextField(
                      decoration: InputDecoration(
                          filled: true,
                          hintText: 'nasi kuning',
                          suffixIcon: Icon(Icons.search),
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.all(15),
                          isDense: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          )),
                    ),
                  ),
                ),
              ),

              // Other Sliver Widgets
              SliverList(
                delegate: SliverChildListDelegate([
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ItemCarousel(listOption: searchResult),
                  ),
                  Divider(
                    height: 7,
                    thickness: 7,
                    indent: 0,
                    endIndent: 0,
                    color: Color.fromARGB(255, 187, 186, 186),
                  ),
                  Container(
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Other items you might like',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ItemCarousel(
                          listOption: allMeal,
                        ),
                      )
                    ]),
                  ),
                ]),
              ),
            ],
          ),
        ));
  }
}
