import 'package:intl/intl.dart';
import 'package:untitled5/item_dto.dart';

class NewsDTO {
  DateTime? lastBuildDate;
  int total;
  int start;
  int display;
  List<ItemDTO> items;

  NewsDTO(this.lastBuildDate, this.total, this.start, this.display, this.items);

  NewsDTO.fromJson(Map<String, dynamic> json)
      : total = json["total"],
        start = json["start"],
        display = json["display"],
        lastBuildDate = json["lastBuildDate"] == null ? null : DateFormat("EEE, dd MMM yyyy HH:mm:ss Z").parse(json["lastBuildDate"]),
        // lastBuildDate = json["lastBuildDate"],
        items = (json["items"] as List).map((jsonItem) => ItemDTO.fromJson(jsonItem)).toList();

  @override
  String toString() {
    return 'NewsDTO{lastBuildDate: $lastBuildDate, total: $total, start: $start, display: $display, items: $items}';
  }
}
