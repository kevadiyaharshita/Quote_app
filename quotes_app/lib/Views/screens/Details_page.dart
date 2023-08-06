import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lorem_ipsum/lorem_ipsum.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quotes_app/modals/quotes_modal.dart';
import 'package:quotes_app/utils/color_utils.dart';
import 'package:share_extend/share_extend.dart';

import '../../utils/canvas_utils.dart';

class Detail_Page extends StatefulWidget {
  const Detail_Page({super.key});

  @override
  State<Detail_Page> createState() => _Detail_PageState();
}

class _Detail_PageState extends State<Detail_Page> {
  List<Color> fontColorList = [
    Colors.black,
    Colors.white,
    theme_4,
    Color(0xffE3B7A0),
    Color(0xffFF6666),
    Color(0xffFF8989),
    Color(0xffFCAEAE),
    Color(0xffFFEADD),
    Color(0xffA78295),
    Color(0xff73777B),
    Color(0xff826F66),
    Color(0xff99627A),
    Color(0xff867070),
    Color(0xff9E7676),
    Color(0xffBB9981),
    Color(0xff6B728E),
    Color(0xffC1A3A3),
    Color(0xff845460),
    Color(0xffF3C5C5),
    theme_11,
    theme_22,
    theme_33,
    theme_44,
    theme_55,
    theme_66,
    theme_77,
    theme_88,
    theme_99,
    ...Colors.primaries
  ];
  Color ftColor = theme_4;
  Color? currentColour;
  Color pickerColor = theme_4;

  void ChangeColor(Color color) {
    setState(() {
      pickerColor = color;
    });
  }

  void bgChangeColor(Color color) {
    setState(() {
      bgpickerColor = color;
    });
  }

  bool Color_Picker_Visibility = false;
  Color bgColor = theme_1;
  Color bgpickerColor = theme_1;
  Color? bgGradientColor;
  String? canvasImage;

  Color bggradient_1 = bg_gradient_colorList[0]['Color1'];
  Color bggradient_2 = bg_gradient_colorList[0]['Color2'];
  String bgColourSlider = "BackGround Color";

  List<TextStyle> quoteFontFamily = [
    GoogleFonts.abel(),
    GoogleFonts.roboto(),
    GoogleFonts.dancingScript(),
    GoogleFonts.bitter(),
    GoogleFonts.anton(),
    GoogleFonts.yatraOne(),
    GoogleFonts.pacifico(),
    GoogleFonts.fjallaOne(),
    GoogleFonts.shadowsIntoLight(),
    GoogleFonts.indieFlower(),
    GoogleFonts.zillaSlab(),
    GoogleFonts.satisfy(),
    GoogleFonts.permanentMarker(),
    GoogleFonts.amaticSc(),
    GoogleFonts.cinzel(),
    GoogleFonts.sairaCondensed(),
    GoogleFonts.kalam(),
    GoogleFonts.courgette(),
    GoogleFonts.righteous(),
    GoogleFonts.tinos(),
    GoogleFonts.lobster(),
    GoogleFonts.changa(),
    GoogleFonts.greatVibes(),
    GoogleFonts.zeyada(),
    GoogleFonts.aladin(),
    GoogleFonts.kaushanScript(),
    GoogleFonts.pathwayGothicOne(),
    GoogleFonts.sacramento()
  ];

  late List<String> quoteFontFamilyName;
  int? fontFamilyIndexVal;

  bool fontEditingVisibility = false;
  bool canvasEditingVisibility = false;

  bool font_fontfamily_editing = true;
  bool font_fontColor_editing = false;
  bool font_fontAlign_editing = false;
  bool font_editing_done = false;

  double fontOpacity = 1;
  TextAlign quoteAlign = TextAlign.center;

  FontWeight qouteFontWeight = FontWeight.bold;
  double quoteFontSize = 22;
  double quoteLetterSpace = 1;

  bool gradientEditing = true;
  bool canvasEditing = false;
  bool imageEditing = false;

  GlobalKey key = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    quoteFontFamilyName =
        List.generate(quoteFontFamily.length, (index) => loremIpsum(words: 3));
  }

  @override
  Widget build(BuildContext context) {
    Quote quote_data = ModalRoute.of(context)!.settings.arguments as Quote;
    Size s = MediaQuery.of(context).size;
    double h = s.height;
    double w = s.width;

    return Scaffold(
      appBar: AppBar(
        title:
            Text("Detail Page", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        foregroundColor: theme_4,
        backgroundColor: theme_1,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios_new_rounded),
        ),
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  quoteLetterSpace = 1;
                  quoteFontSize = 22;
                  qouteFontWeight = FontWeight.bold;
                  quoteAlign = TextAlign.center;
                  fontOpacity = 1;
                  ftColor = theme_4;
                  fontFamilyIndexVal = null;
                  bgColor = theme_1;
                  bgColourSlider = "BackGround Color";
                  canvasImage = null;
                });
              },
              icon: Icon(
                Icons.refresh,
                size: 25,
              )),
          IconButton(
              onPressed: () async {
                setState(() {
                  Clipboard.setData(
                    ClipboardData(
                        text:
                            "${quote_data.quote}\n\n-${quote_data.author}\n\n\nI've got this exciting quote from: Quotes App\n"),
                  ).then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Quote copied !!",
                          style: TextStyle(color: theme_1, fontSize: 18),
                        ),
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: theme_4,
                      ),
                    );
                  });
                });
              },
              icon: Icon(
                Icons.copy,
                size: 25,
              ))
        ],
      ),
      body: Column(
        children: [
          // SizedBox(height: 30,),
          RepaintBoundary(
            key: key,
            child: Container(
              width: w,
              height: 400,
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: (bgColourSlider == "BackGround Color") ? bgColor : null,
                gradient: (bgColourSlider == "Gradient Color")
                    ? LinearGradient(
                        colors: [bggradient_1, bggradient_2],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter)
                    : null,
                image: (canvasImage != null)
                    ? DecorationImage(
                        image: NetworkImage(canvasImage!), fit: BoxFit.fill)
                    : null,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey, offset: Offset(5, 5), blurRadius: 12)
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Spacer(),
                  SelectableText(
                    quote_data.quote,
                    // overflow: TextOverflow.ellipsis,
                    maxLines: 7,
                    style: (fontFamilyIndexVal != null)
                        ? quoteFontFamily[fontFamilyIndexVal!].merge(
                            TextStyle(
                                letterSpacing: quoteLetterSpace,
                                fontWeight: qouteFontWeight,
                                fontSize: quoteFontSize,
                                color: (ftColor == null)
                                    ? theme_4.withOpacity(fontOpacity)
                                    : ftColor.withOpacity(fontOpacity)),
                          )
                        : TextStyle(
                            letterSpacing: quoteLetterSpace,
                            fontWeight: qouteFontWeight,
                            fontSize: quoteFontSize,
                            color: (ftColor == null)
                                ? theme_4.withOpacity(fontOpacity)
                                : ftColor.withOpacity(fontOpacity)),
                    textAlign: quoteAlign,
                  ),
                  Spacer(
                    flex: 2,
                  ),
                  Text(
                    "- ${quote_data.author}",
                    style: (fontFamilyIndexVal != null)
                        ? quoteFontFamily[fontFamilyIndexVal!].merge(
                            TextStyle(
                                fontWeight: qouteFontWeight,
                                fontSize: quoteFontSize - 2,
                                color: (ftColor == null)
                                    ? theme_4.withOpacity(fontOpacity)
                                    : ftColor.withOpacity(fontOpacity)),
                          )
                        : TextStyle(
                            fontWeight: qouteFontWeight,
                            fontSize: quoteFontSize - 2,
                            color: (ftColor == null)
                                ? theme_4.withOpacity(fontOpacity)
                                : ftColor.withOpacity(fontOpacity)),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
          Spacer(),

          //bottom options
          Visibility(
            visible: (!fontEditingVisibility && !canvasEditingVisibility),
            child: Container(
              width: w,
              height: 70,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              decoration: BoxDecoration(color: theme_1, boxShadow: [
                BoxShadow(
                    offset: Offset(-2, -2), color: Colors.grey, blurRadius: 3),
              ]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        canvasEditingVisibility = true;
                        fontEditingVisibility = false;
                      });
                    },
                    child: Container(
                      width: 100,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Icon(
                            Icons.gradient_outlined,
                            size: 30,
                            color: theme_4,
                          ),
                          Text(
                            "Canvas",
                            style: TextStyle(
                              color: theme_4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        canvasEditingVisibility = false;
                        fontEditingVisibility = true;
                      });
                    },
                    child: Container(
                      width: 100,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Icon(
                            Icons.text_fields,
                            size: 30,
                            color: theme_4,
                          ),
                          Text(
                            "Text",
                            style: TextStyle(
                              color: theme_4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  //share
                  GestureDetector(
                    onTap: () async {
                      print("Sharing started...");

                      final boundary = key.currentContext?.findRenderObject()
                          as RenderRepaintBoundary?;
                      final image = await boundary?.toImage(pixelRatio: 12);
                      final byteData =
                          await image?.toByteData(format: ImageByteFormat.png);
                      final imageBytes = byteData?.buffer.asUint8List();

                      if (imageBytes != null) {
                        print("Bytes generated...");

                        final directory =
                            await getApplicationDocumentsDirectory();
                        final imagePath =
                            await File('${directory.path}/container_image.png')
                                .create();
                        await imagePath.writeAsBytes(imageBytes);

                        ShareExtend.share(imagePath.path, "file")
                            .then((value) => print("Sharedd.."))
                            .onError((error, stackTrace) => print("Eroor..."));
                      }
                    },
                    child: Container(
                      width: 100,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Icon(
                            Icons.share,
                            size: 30,
                            color: theme_4,
                          ),
                          Text(
                            "Share",
                            style: TextStyle(
                              color: theme_4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          //fontEditing visibility
          Visibility(
            visible: fontEditingVisibility,
            child: Container(
              width: w,
              height: 300,
              color: theme_4,
              child: Column(
                children: [
                  //options of fontsediting
                  Container(
                    width: w,
                    height: 55,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(color: theme_1, boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(-4, -4),
                          blurRadius: 5),
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(2, 2),
                          blurRadius: 5),
                    ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              setState(() {
                                font_fontfamily_editing = true;
                                font_fontColor_editing = false;
                                font_fontAlign_editing = false;
                                if (fontFamilyIndexVal == null) {
                                  fontFamilyIndexVal = 0;
                                }
                              });
                            },
                            icon: Icon(
                              Icons.font_download_outlined,
                              size: 30,
                              color: (font_fontfamily_editing)
                                  ? theme_4
                                  : theme_4.withOpacity(0.5),
                            )),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                font_fontColor_editing = true;
                                font_fontfamily_editing = false;
                                font_fontAlign_editing = false;
                              });
                            },
                            icon: Icon(
                              Icons.color_lens_outlined,
                              size: 30,
                              color: (font_fontColor_editing)
                                  ? theme_4
                                  : theme_4.withOpacity(0.5),
                            )),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                font_fontAlign_editing = true;
                                font_fontColor_editing = false;
                                font_fontfamily_editing = false;
                              });
                            },
                            icon: Icon(
                              Icons.format_align_center_rounded,
                              size: 30,
                              color: (font_fontAlign_editing)
                                  ? theme_4
                                  : theme_4.withOpacity(0.5),
                            )),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                fontEditingVisibility = false;
                              });
                            },
                            icon: Icon(
                              Icons.expand_more_rounded,
                              size: 40,
                              color: theme_4.withOpacity(0.5),
                            )),
                      ],
                    ),
                  ),

                  // font Family
                  Visibility(
                    visible: font_fontfamily_editing,
                    child: Expanded(
                      child: Container(
                        width: w,
                        height: 300 - 70,
                        child: Stack(
                          children: [
                            Center(
                              child: Container(
                                width: w - 30,
                                height: 45,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: theme_1.withOpacity(0.5),
                                ),
                              ),
                            ),
                            ListWheelScrollView(
                                itemExtent: 50,
                                perspective: 0.01,
                                diameterRatio: 2.5,
                                squeeze: 1,
                                onSelectedItemChanged: (val) {
                                  setState(() {
                                    fontFamilyIndexVal = val;
                                  });
                                },
                                children: List.generate(quoteFontFamily.length,
                                    (index) {
                                  return Container(
                                    height: 70,
                                    width: w,
                                    alignment: Alignment.center,
                                    child: Text(quoteFontFamilyName[index],
                                        style: quoteFontFamily[index].merge(
                                            TextStyle(
                                                color: (index ==
                                                        fontFamilyIndexVal)
                                                    ? theme_1
                                                    : theme_1.withOpacity(0.5),
                                                fontSize: 24))),
                                  );
                                })),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // font Colour
                  Visibility(
                    visible: font_fontColor_editing,
                    child: Expanded(
                      child: Container(
                          width: w,
                          height: 300 - 70,
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Font Opacity",
                                    style: TextStyle(
                                        color: theme_1,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: Slider(
                                          value: fontOpacity,
                                          min: 0.2,
                                          max: 1,
                                          activeColor: theme_1,
                                          inactiveColor:
                                              theme_3.withOpacity(0.4),
                                          onChanged: (val) {
                                            setState(() {
                                              fontOpacity = val;
                                            });
                                          }),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Colour",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: theme_1),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Expanded(
                                child: Container(
                                  width: w,
                                  // color: theme_1.withOpacity(0.3),
                                  child: SingleChildScrollView(
                                    child: Wrap(
                                      children: [
                                        //colour picker
                                        Container(
                                          width: 60,
                                          height: 60,
                                          margin: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: theme_4,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey,
                                                  blurRadius: 5,
                                                  // offset: Offset(2,2)
                                                )
                                              ]),
                                          child: IconButton(
                                            onPressed: () {
                                              setState(
                                                () => showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          AlertDialog(
                                                    title: Text("Pick Color"),
                                                    content:
                                                        SingleChildScrollView(
                                                            child: ColorPicker(
                                                      pickerColor: pickerColor,
                                                      onColorChanged:
                                                          ChangeColor,
                                                    )),
                                                    actions: [
                                                      ElevatedButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              ftColor =
                                                                  pickerColor;
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            });
                                                          },
                                                          child: Text("Got it"))
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                            icon: Icon(
                                              Icons.colorize_rounded,
                                              size: 35,
                                              color: theme_1,
                                            ),
                                          ),
                                        ),
                                        ...fontColorList
                                            .map((e) => GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      ftColor = e;
                                                    });
                                                  },
                                                  child: Container(
                                                    width: 60,
                                                    height: 60,
                                                    margin: EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: e,
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey,
                                                            blurRadius: 5,
                                                            // offset: Offset(2,2)
                                                          )
                                                        ]),
                                                  ),
                                                ))
                                            .toList()
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                  ),

                  //font Align
                  Visibility(
                    visible: font_fontAlign_editing,
                    child: Container(
                      width: w,
                      height: 300 - 70,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          // SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              //alignment
                              Container(
                                width: 150,
                                height: 80,
                                // color: Colors.grey,
                                child: Column(
                                  children: [
                                    Text(
                                      "Alignment",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: theme_1.withOpacity(0.5)),
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                quoteAlign = TextAlign.left;
                                              });
                                            },
                                            icon: Icon(
                                              Icons.format_align_left_outlined,
                                              color: (quoteAlign ==
                                                      TextAlign.left)
                                                  ? theme_1
                                                  : theme_1.withOpacity(0.5),
                                            )),
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                quoteAlign = TextAlign.center;
                                              });
                                            },
                                            icon: Icon(
                                                Icons
                                                    .format_align_center_outlined,
                                                color: (quoteAlign ==
                                                        TextAlign.center)
                                                    ? theme_1
                                                    : theme_1
                                                        .withOpacity(0.5))),
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                quoteAlign = TextAlign.right;
                                              });
                                            },
                                            icon: Icon(
                                                Icons
                                                    .format_align_right_outlined,
                                                color: (quoteAlign ==
                                                        TextAlign.right)
                                                    ? theme_1
                                                    : theme_1
                                                        .withOpacity(0.5))),
                                      ],
                                    )
                                  ],
                                ),
                              ),

                              // Spacer(),

                              //font weight
                              Container(
                                width: 150,
                                height: 80,
                                // color: Colors.grey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Font Weight",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: theme_1.withOpacity(0.5)),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              qouteFontWeight =
                                                  FontWeight.normal;
                                            });
                                          },
                                          child: Text(
                                            "ABC",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.normal,
                                                color: (qouteFontWeight ==
                                                        FontWeight.normal)
                                                    ? theme_1
                                                    : theme_1.withOpacity(0.5)),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              qouteFontWeight = FontWeight.bold;
                                            });
                                          },
                                          child: Text(
                                            "ABC",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: (qouteFontWeight ==
                                                        FontWeight.bold)
                                                    ? theme_1
                                                    : theme_1.withOpacity(0.5)),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          // Spacer(),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              //font size
                              Container(
                                width: 150,
                                height: 80,
                                // color: Colors.grey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Font Size",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: theme_1.withOpacity(0.5)),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                quoteFontSize--;
                                              });
                                            },
                                            icon: Icon(
                                              Icons.text_decrease,
                                              color: theme_1,
                                            )),
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                quoteFontSize++;
                                              });
                                            },
                                            icon: Icon(
                                              Icons.text_increase,
                                              color: theme_1,
                                            )),
                                      ],
                                    )
                                  ],
                                ),
                              ),

                              //latter spacing
                              Container(
                                width: 150,
                                height: 80,
                                // color: Colors.grey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Letter Spacing",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: theme_1.withOpacity(0.5)),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                quoteLetterSpace--;
                                              });
                                            },
                                            icon: Icon(
                                              Icons.text_decrease,
                                              color: theme_1,
                                            )),
                                        IconButton(
                                            onPressed: () {
                                              setState(() {
                                                quoteLetterSpace++;
                                              });
                                            },
                                            icon: Icon(
                                              Icons.text_increase,
                                              color: theme_1,
                                            )),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          //canvasEditing Visibility
          Visibility(
            visible: canvasEditingVisibility,
            child: Container(
              width: w,
              height: 300,
              color: theme_4,
              child: Column(
                children: [
                  //canvas options
                  Container(
                    width: w,
                    height: 55,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(color: theme_1, boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(-4, -4),
                          blurRadius: 5),
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(2, 2),
                          blurRadius: 5),
                    ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              gradientEditing = true;
                              canvasEditing = false;
                              imageEditing = false;
                            });
                          },
                          icon: Icon(
                            Icons.color_lens_outlined,
                            size: 30,
                            color: (gradientEditing)
                                ? theme_4
                                : theme_4.withOpacity(0.5),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                canvasEditing = true;
                                gradientEditing = false;
                                imageEditing = false;
                              });
                            },
                            icon: Icon(
                              Icons.gradient,
                              size: 30,
                              color: (canvasEditing)
                                  ? theme_4
                                  : theme_4.withOpacity(0.5),
                            )),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                canvasEditingVisibility = false;
                              });
                            },
                            icon: Icon(
                              Icons.expand_more_rounded,
                              size: 40,
                              color: theme_4.withOpacity(0.5),
                            )),
                      ],
                    ),
                  ),

                  //bgColor
                  Visibility(
                    visible: gradientEditing,
                    child: Container(
                      width: w,
                      height: 300 - 70,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: CupertinoSlidingSegmentedControl(
                              children: {
                                "BackGround Color": Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Text("BackGround Color",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: theme_4.withOpacity(0.7))),
                                ),
                                "Gradient Color": Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Text(
                                    "Gradient Color",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: theme_4.withOpacity(0.7)),
                                  ),
                                )
                              },
                              backgroundColor: theme_1.withOpacity(0.5),
                              thumbColor: theme_1,
                              groupValue: bgColourSlider,
                              onValueChanged: (val) {
                                setState(() {
                                  bgColourSlider = val!;
                                });
                              },
                            ),
                          ),
                          //back Ground color
                          Visibility(
                            visible: (bgColourSlider == "BackGround Color"),
                            child: Expanded(
                              child: Container(
                                  width: w,
                                  height: 300 - 70,
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Expanded(
                                        child: Container(
                                          width: w,
                                          // color: theme_1.withOpacity(0.3),
                                          child: SingleChildScrollView(
                                            child: Wrap(children: [
                                              Container(
                                                width: 60,
                                                height: 60,
                                                margin: EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: theme_4,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey,
                                                        blurRadius: 5,
                                                        // offset: Offset(2,2)
                                                      )
                                                    ]),
                                                child: IconButton(
                                                  onPressed: () {
                                                    setState(
                                                      () => showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                                context) =>
                                                            AlertDialog(
                                                          title: Text(
                                                              "Pick Color"),
                                                          content:
                                                              SingleChildScrollView(
                                                                  child:
                                                                      ColorPicker(
                                                            pickerColor:
                                                                bgpickerColor,
                                                            onColorChanged:
                                                                bgChangeColor,
                                                          )),
                                                          actions: [
                                                            ElevatedButton(
                                                                onPressed: () {
                                                                  setState(() {
                                                                    bgColor =
                                                                        bgpickerColor;
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  });
                                                                },
                                                                child: Text(
                                                                    "Got it"))
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  icon: Icon(
                                                    Icons.colorize_rounded,
                                                    size: 35,
                                                    color: theme_1,
                                                  ),
                                                ),
                                              ),
                                              ...fontColorList
                                                  .map((e) => GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            bgColor = e;
                                                            canvasImage = null;
                                                          });
                                                        },
                                                        child: Container(
                                                          width: 60,
                                                          height: 60,
                                                          margin:
                                                              EdgeInsets.all(8),
                                                          decoration:
                                                              BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: e,
                                                                  boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .grey,
                                                                  blurRadius: 5,
                                                                  // offset: Offset(2,2)
                                                                )
                                                              ]),
                                                        ),
                                                      ))
                                                  .toList(),
                                            ]),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ),

                          //gradient color
                          Visibility(
                            visible: (bgColourSlider == "Gradient Color"),
                            child: Expanded(
                              child: Container(
                                  width: w,
                                  height: 300 - 70,
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Expanded(
                                        child: Container(
                                          width: w,
                                          // color: theme_1.withOpacity(0.3),
                                          child: SingleChildScrollView(
                                            child: Wrap(
                                                children: bg_gradient_colorList
                                                    .map((e) => GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              bggradient_1 =
                                                                  e['Color1'];
                                                              bggradient_2 =
                                                                  e['Color2'];
                                                              canvasImage =
                                                                  null;
                                                            });
                                                          },
                                                          child: Container(
                                                            width: 80,
                                                            height: 80,
                                                            margin:
                                                                EdgeInsets.all(
                                                                    8),
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                gradient: LinearGradient(
                                                                    colors: [
                                                                      e['Color1'],
                                                                      e['Color2']
                                                                    ],
                                                                    begin: Alignment
                                                                        .topCenter,
                                                                    end: Alignment
                                                                        .bottomCenter),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .grey,
                                                                    blurRadius:
                                                                        5,
                                                                    // offset: Offset(2,2)
                                                                  )
                                                                ]),
                                                          ),
                                                        ))
                                                    .toList()),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  //images
                  Visibility(
                    visible: canvasEditing,
                    child: Container(
                      width: w,
                      height: 300 - 70,
                      child: SingleChildScrollView(
                        child: Wrap(
                          children: Canvas_Images.map((e) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    canvasImage = e;
                                  });
                                },
                                child: Container(
                                  width: 180,
                                  height: 180,
                                  margin: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          image: NetworkImage(e),
                                          fit: BoxFit.fill)),
                                ),
                              )).toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          //Share Visibility
        ],
      ),
      backgroundColor: theme_4,
    );
  }
}
