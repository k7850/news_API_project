import 'package:intl/intl.dart';

class ItemDTO {
  String title;
  String originallink;
  String link;
  String description;
  DateTime? pubDate;
  bool isClick;
  bool isLastClick;

  ItemDTO(this.title, this.originallink, this.link, this.description, this.isClick, this.isLastClick, this.pubDate);

  ItemDTO.fromJson(Map<String, dynamic> json)
      : title = json["title"],
        originallink = json["originallink"],
        link = json["link"],
        description = json["description"],
        isClick = false,
        isLastClick = false,
        pubDate = json["pubDate"] == null ? null : DateFormat("EEE, dd MMM yyyy HH:mm:ss Z").parse(json["pubDate"]);
  // pubDate = json["pubDate"];

  @override
  String toString() {
    return 'ItemDTO{title: $title, originallink: $originallink, link: $link, description: $description, pubDate: $pubDate, isClick: $isClick, isLastClick: $isLastClick}';
  }
}
