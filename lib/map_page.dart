import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:image_pixels/image_pixels.dart';
import 'package:untitled5/background_color.dart';
import 'package:untitled5/news_page.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Uint8List? myImageBytes;
  final AssetImage myImage = AssetImage("assets/2ccc.png");

  Offset localPosition = Offset(-1, -1);
  Color clickColor = Color(0x00000000);
  double imageScale = 1.0;

  @override
  Widget build(BuildContext context) {
    double imageWidth = 1000;
    double imageHeight = 893;
    double deviceWidth = sizeGetScreenWidth(context);
    double deviceHeight = sizeGetScreenWidth(context) * (imageHeight / imageWidth);

    return Scaffold(
      appBar: AppBar(
        title: Text("우리 동네 뉴스"),
        backgroundColor: Colors.green,
        centerTitle: true,
        actions: [
          Icon(Icons.search),
          SizedBox(width: 10),
        ],
        elevation: 1,
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Text("부산", style: TextStyle(fontSize: 20)),
          Text("지역을 선택하세요.", style: TextStyle(fontSize: 15)),
          SizedBox(height: 5),
          InteractiveViewer(
            maxScale: 5.0,
            onInteractionUpdate: (ScaleUpdateDetails details) {
              setState(() {
                imageScale = details.scale;
              });
            },
            child: Listener(
              onPointerMove: (PointerMoveEvent details) {
                print("onPointerMove");
                double imageX = getImageX(details.localPosition.dx, imageWidth, deviceWidth, imageScale);
                double imageY = getImageY(details.localPosition.dy, imageHeight, deviceHeight, imageScale);
                localPosition = Offset(imageX, imageY);
              },
              onPointerDown: (PointerDownEvent details) async {
                print("onPointerDown");
                double imageX = getImageX(details.localPosition.dx, imageWidth, deviceWidth, imageScale);
                double imageY = getImageY(details.localPosition.dy, imageHeight, deviceHeight, imageScale);
                localPosition = Offset(imageX, imageY);

                int red = (clickColor.value & 0xFF0000) >> 16;
                int green = (clickColor.value & 0x00FF00) >> 8;
                int blue = clickColor.value & 0x0000FF;

                if (!(red == 255 && red == 255 && blue == 255)) {
                  var newImageBytes = await BackgroundColor.changeBackgroundOfImage(
                    bytes: (await rootBundle.load("assets/2ccc.png")).buffer.asUint8List(),
                    removeColorRGB: [red, green, blue],
                    addColorRGB: [2, 2, 2],
                  );
                  myImageBytes = newImageBytes;
                }
                setState(() {});
              },
              child: ImagePixels(
                imageProvider: myImage,
                builder: (BuildContext context, ImgDetails img) {
                  int x = getImageX(localPosition.dx, imageWidth, imageWidth, 1.0).toInt();
                  int y = getImageY(localPosition.dy, imageHeight, imageHeight, 1.0).toInt();

                  var color = img.pixelColorAt!(x, y);

                  WidgetsBinding.instance!.addPostFrameCallback((_) {
                    if (mounted) {
                      setState(() {
                        // if (clickColor == Color(0xff22b14c)) {
                        //   print("색깔지정");
                        //   where = "특정 색상 지역";
                        // }
                        if (color != this.clickColor) {
                          this.clickColor = color;
                        }
                      });
                    }
                  });

                  // print("${myImageBytes == null}");
                  return myImageBytes == null
                      ? Image(
                          image: myImage,
                          width: deviceWidth,
                          height: deviceHeight,
                        )
                      : Image.memory(
                          myImageBytes!,
                          width: deviceWidth,
                          height: deviceHeight,
                        );
                },
              ),
            ),
          ),
          SizedBox(height: 5),
          // Container(decoration: BoxDecoration(border: Border.all(width: 2), color: clickColor), width: 75, height: 55),
          // Text("${localPosition}"),
          // Text("${clickColor}"),
          getColorString(clickColor) == "색깔없음" ? SizedBox(height: 50) : SvgPicture.asset("assets/${getColorString(clickColor)}.svg", height: 50),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => NewsPage(where: getColorString(clickColor))));
            },
            style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(clickColor)),
            child: Text("${getColorString(clickColor)} 뉴스 보기", style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }
}

String getColorString(Color color) {
  if (color == Color(0xff22b14c)) {
    return "강서구";
  } else if (color == Color(0xfffff200)) {
    return "사하구";
  } else if (color == Color(0xff00a2e8)) {
    return "사상구";
  } else if (color == Color(0xffc8bfe7)) {
    return "북구";
  } else if (color == Color(0xfffa9696)) {
    return "부산진구";
  } else if (color == Color(0xffffc90e)) {
    return "연제구";
  } else if (color == Color(0xfffa6464)) {
    return "동래구";
  } else if (color == Color(0xff9696fa)) {
    return "금정구";
  } else if (color == Color(0xff64fa64)) {
    return "서구";
  } else if (color == Color(0xffb5e61d)) {
    return "중구";
  } else if (color == Color(0xff99d9ea)) {
    return "동구";
  } else if (color == Color(0xff6464fa)) {
    return "남구";
  } else if (color == Color(0xffffaec9)) {
    return "수영구";
  } else if (color == Color(0xff96fa96)) {
    return "해운대구";
  } else if (color == Color(0xff7092be)) {
    return "영도구";
  } else if (color == Color(0xffefe4b0)) {
    return "기장군";
  } else {
    return "색깔없음";
  }
}

double sizeGetScreenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double sizeGetScreenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double getImageX(double screenX, double imageWidth, double screenWidth, double scale) {
  return (screenX / screenWidth) * (imageWidth * scale);
}

double getImageY(double screenY, double imageHeight, double screenHeight, double scale) {
  return (screenY / screenHeight) * (imageHeight * scale);
}
