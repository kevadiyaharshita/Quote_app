import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';
import 'package:quotes_app/modals/quotes_modal.dart';
import 'package:quotes_app/utils/MyRoutes.dart';
import '../../utils/color_utils.dart';
import '../../utils/quotes_utils.dart';
import 'package:lorem_ipsum_generator/lorem_ipsum_generator.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Random r = Random();
  String SelectedCategory = "All";
  int item_Count = 0;
  bool isGrid = false;

  // List<Color> Random_Color = [theme_11,theme_22,theme_33,theme_44,theme_55,theme_66,theme_77,theme_88,theme_99];

  List<Color> Random_Color = [
    theme_2,
    theme_3, theme_2,
    theme_3, theme_2,
    theme_3, theme_2,
    theme_3, theme_2,
    theme_3, theme_2,
    theme_3, theme_2,
    theme_3, theme_2,
    theme_3, theme_2,
    theme_3, theme_2,
    theme_3, theme_2,
    theme_3, theme_2,
    theme_3, theme_2,
    theme_3, theme_2,
    theme_3, theme_2,
    theme_3, theme_2,
    theme_3, theme_2,
    theme_3,
    // Color(0xffA78295),
    // Color(0xff73777B),
    // // Color(0xff826F66),
    // Color(0xff99627A),
    // Color(0xff867070),
    // Color(0xff9E7676),
    // // Color(0xffBB9981),
    // Color(0xff6B728E),
    // Color(0xffC1A3A3),
    // Color(0xff845460),
    // // Color(0xff92817A),
    // // Color(0xff7E7474),
    // // Color(0xff92817A),
    // // Color(0xff9F8772),
    // Color(0xff886F6F),
    // Color(0xff6C4A4A),
  ];

  List<Quote> Random_Quote = List.generate(
      allQuoteData.length, (index) => Quote.fromMap(data: allQuoteData[index]));

  @override
  void initState() {
    super.initState();
    getQuote();
    Random_Quote.shuffle();
    Random_Color.shuffle();
  }

  getQuote() {
    int index = r.nextInt(allQuotes.length);
    Future.delayed(Duration(milliseconds: 500), () {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                backgroundColor: theme_4,
                contentTextStyle: TextStyle(
                  color: theme_1,
                ),
                titleTextStyle: TextStyle(color: theme_1),
                title: Text(
                  "Todays Quotes",
                  style: TextStyle(
                      color: theme_1,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                content: Text(allQuotes[index].quote),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: theme_4, foregroundColor: theme_1),
                    child: Text(
                      "Go to APP",
                      style: TextStyle(color: theme_1),
                    ),
                  )
                ],
              ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool willpop = await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  backgroundColor: theme_4,
                  title: Text("Are you sure to Exit?"),
                  content: Text(loremIpsum(words: 10)),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      child: Text("YES"),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: theme_4, foregroundColor: theme_1),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Text(
                          "NO",
                          style: TextStyle(color: theme_1),
                        )),
                  ],
                ));
        return willpop;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Quotes App",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          // centerTitle: true,
          foregroundColor: theme_4,
          backgroundColor: theme_1,
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  isGrid = !isGrid;
                });
              },
              icon: Icon((isGrid) ? Icons.view_list : Icons.grid_view_rounded),
            )
          ],
        ),
        body: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                height: 75,
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  color: theme_1.withOpacity(1),
                ),
                child: Row(children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        SelectedCategory = "All";
                      });
                    },
                    child: Container(
                      height: 50,
                      padding: EdgeInsets.all(12),
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                          color:
                              (SelectedCategory == "All") ? theme_4 : theme_1,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: theme_4)),
                      child: Text(
                        "All",
                        style: TextStyle(
                            color:
                                (SelectedCategory == "All") ? theme_1 : theme_4,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  ...allCategories
                      .map((e) => GestureDetector(
                            onTap: () {
                              setState(() {
                                SelectedCategory = e;
                              });
                            },
                            child: Container(
                              height: 50,
                              padding: EdgeInsets.all(12),
                              margin: EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                  color: (SelectedCategory == e)
                                      ? theme_4
                                      : theme_1,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: theme_4)),
                              child: Text(
                                e,
                                style: TextStyle(
                                    color: (SelectedCategory == e)
                                        ? theme_1
                                        : theme_4,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ))
                      .toList(),
                ]),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Expanded(
              child: (isGrid)
                  ? SingleChildScrollView(
                      child: StaggeredGrid.count(
                        crossAxisCount: 2,
                        children: List.generate(
                            allQuotes.length,
                            (index) => (SelectedCategory == "All")
                                ? StaggeredGridTile.count(
                                    crossAxisCellCount: 1,
                                    mainAxisCellCount: index % 2 == 0 ? 1 : 1.5,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                            MyRoutes.detail_page,
                                            arguments: Random_Quote[index]);
                                      },
                                      child: Card(
                                        color: Random_Color[index % 9],
                                        child: Container(
                                          padding: EdgeInsets.all(16),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Spacer(),
                                              Text(
                                                Random_Quote[index].quote,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 3,
                                                style: TextStyle(
                                                    color: theme_4,
                                                    fontSize: 20),
                                              ),
                                              Spacer(
                                                flex: 2,
                                              ),
                                              Text(
                                                  " - ${Random_Quote[index].author}",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      color: theme_4,
                                                      fontSize: 16)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : (SelectedCategory ==
                                        allQuotes[index].category)
                                    ? StaggeredGridTile.count(
                                        crossAxisCellCount: 1,
                                        mainAxisCellCount:
                                            index % 2 == 0 ? 1 : 1.5,
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).pushNamed(
                                                MyRoutes.detail_page,
                                                arguments: allQuotes[index]);
                                          },
                                          child: Card(
                                            color: Random_Color[index % 9],
                                            child: Container(
                                              padding: EdgeInsets.all(16),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Spacer(),
                                                  Text(allQuotes[index].quote,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 3,
                                                      style: TextStyle(
                                                          color: theme_4,
                                                          fontSize: 20)),
                                                  Spacer(
                                                    flex: 2,
                                                  ),
                                                  Text(
                                                      " - ${allQuotes[index].author}",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          color: theme_4,
                                                          fontSize: 16)),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container()),
                      ),
                    )

                  //********************************
                  : ListView.builder(
                      itemCount: allQuotes.length,
                      itemBuilder: (context, index) => (SelectedCategory ==
                              "All")
                          ? Padding(
                              // padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                              padding: EdgeInsets.all(0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      MyRoutes.detail_page,
                                      arguments: Random_Quote[index]);
                                },
                                child: Card(
                                  color: Random_Color[index % 9],
                                  child: Container(
                                    height: 100,
                                    padding: EdgeInsets.all(10),
                                    child: ListTile(
                                      title: Text(Random_Quote[index].quote,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: TextStyle(
                                              color: theme_4, fontSize: 16)),
                                      subtitle: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                              " - ${Random_Quote[index].category}",
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              style: TextStyle(
                                                color: theme_4,
                                                fontSize: 16,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : (allQuotes[index].category == SelectedCategory)
                              ? GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        MyRoutes.detail_page,
                                        arguments: allQuotes[index]);
                                  },
                                  child: Card(
                                    color: Random_Color[index % 9],
                                    child: Container(
                                      height: 100,
                                      padding: EdgeInsets.all(10),
                                      child: ListTile(
                                        title: Text(allQuotes[index].quote,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: TextStyle(
                                                color: theme_4, fontSize: 16)),
                                        subtitle: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                                " - ${allQuotes[index].category}",
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: TextStyle(
                                                    color: theme_4,
                                                    fontSize: 16)),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Container()),
            ),
          ],
        ),
        backgroundColor: theme_4,
      ),
    );
  }
}

//
// ElevatedButton(onPressed: (){
// showDialog(context: context, builder: (context) => AlertDialog(
// title: Text("Alert!!"),
// content: Text(loremIpsum(words: 50)),
// ));
//
// }, child: Text("Simple Dialogue Box")),
// ElevatedButton(onPressed: (){
// showDialog(
// context: context,
// barrierDismissible: false,
// builder: (context) => AlertDialog(
// title: Text("Alert!!"),
// content: Text(loremIpsum(words: 10)),
// actions: [
// ElevatedButton(onPressed: (){
// Navigator.of(context).pop();
// }, child: Text("OK")),
// TextButton(onPressed: (){
// Navigator.of(context).pop();
// }, child: Text("CANCEL")),
// ],
// )
// );
//
// }, child: Text("Confirmation Dialogue Box")),
// ElevatedButton(onPressed: (){
// showGeneralDialog(
// context: context,
// pageBuilder: (context, _, __) => Scaffold(
// body: Column(
// children: [
// Spacer(),
// FlutterLogo(size: 350,),
// Spacer(),
// Expanded(
// child: Container(
// width: double.infinity,
// child: Theme(
// data: ThemeData(),
// child: ElevatedButton(
// onPressed: (){
// Navigator.of(context).pop();
// },
// child: Text("BACK"),
// ),
//
// ),
// ),
// )
// ],
// ),
// ),
// );
//
// }, child: Text("general Dialogue Box")),
