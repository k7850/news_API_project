import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled5/is_view.dart';
import 'package:untitled5/news_dto.dart';
import 'package:untitled5/repository.dart';
import 'package:untitled5/response_dto.dart';
import 'package:untitled5/webview_page.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsPage extends StatefulWidget {
  String where;
  NewsPage({required this.where, super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late Future<ResponseDTO> _futureResponse;

  @override
  void initState() {
    super.initState();
    _futureResponse = Repository().naver(widget.where);
  }

  @override
  Widget build(BuildContext context) {
    // Future<ResponseDTO> responseDTO = Repository().naver();
    // if (responseDTO == null) {
    //   return CircularProgressIndicator();
    // }
    print("${widget.where}");

    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.where} 뉴스"),
        backgroundColor: Colors.green,
        centerTitle: true,
        actions: [
          Icon(Icons.search),
          SizedBox(width: 10),
        ],
        elevation: 1,
      ),
      body: FutureBuilder<ResponseDTO>(
        future: _futureResponse,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else {
            ResponseDTO responseDTO = snapshot.data!;
            NewsDTO newsDTO = responseDTO.data as NewsDTO;

            return ListView.separated(
              itemCount: newsDTO.items.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    newsDTO.items[index].isClick = true;

                    newsDTO.items.forEach((item) {
                      item.isLastClick = false;
                    });
                    newsDTO.items[index].isLastClick = true;

                    print("아이템클릭");
                    setState(() {});
                    Navigator.push(context, MaterialPageRoute(builder: (_) => WebviewPage(link: newsDTO.items[index].link)));
                  },
                  child: Stack(
                    children: [
                      Container(
                        color: newsDTO.items[index].isClick == true ? Color.fromRGBO(200, 200, 200, 1) : Colors.white,
                        height: 148,
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(newsDTO.items[index].title,
                                maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                            SizedBox(height: 2),
                            Text("${DateFormat('yyyy-MM-dd HH:mm').format(newsDTO.items[index].pubDate!)}",
                                style: TextStyle(color: Colors.grey[700])),
                            SizedBox(height: 2),
                            Text(newsDTO.items[index].description, maxLines: 4, overflow: TextOverflow.ellipsis),
                          ],
                        ),
                      ),
                      newsDTO.items[index].isLastClick == true
                          ? Positioned(
                              right: 0, child: CustomPaint(size: Size(70, 70), painter: DrawIsView1(color: Color.fromRGBO(150, 150, 150, 1))))
                          : SizedBox(),
                      newsDTO.items[index].isLastClick == true
                          ? Positioned(right: 0, child: CustomPaint(size: Size(70, 70), painter: DrawIsView2(color: Colors.white)))
                          : SizedBox(),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(color: Colors.black54, thickness: 1, height: 1); // 구분선
              },
            );
          }
        },
      ),
    );
  }
}
