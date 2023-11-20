import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:untitled5/http.dart';
import 'package:untitled5/news_dto.dart';
import 'package:untitled5/response_dto.dart';

class Repository {
  Future<ResponseDTO> naver(String where) async {
    print("리포지토리호출");
    try {
      String text = "${where}";
      if (where == "강서구" || where == "북구" || where == "동구" || where == "서구" || where == "남구" || where == "중구") {
        text = "부산 ${where}";
      }

      print("${text}");

      Response response = await dio.get(text + "&display=20",
          options: Options(headers: {"X-Naver-Client-Id": "oxpgdkL48IZqJKweCujW", "X-Naver-Client-Secret": "zbg0ZybsAR"}));

      NewsDTO newsDTO = new NewsDTO.fromJson(response.data);

      // NewsDTO newsDTO = new NewsDTO.fromJson({
      //   "lastBuildDate": "Mon, 20 Nov 2023 13:30:14 +0900",
      //   "total": 283970,
      //   "start": 1,
      //   "display": 10,
      //   "items": [
      //     {
      //       "title": "<b>부산<\/b>시 의료기사단체 총연합회 '연탄나눔 봉사활동' 이웃사랑 실천",
      //       "originallink": "https:\/\/www.viva100.com\/main\/view.php?key=20231120010005792",
      //       "link": "https:\/\/www.viva100.com\/main\/view.php?key=20231120010005792",
      //       "description":
      //           "<b>부산<\/b>시 의료기사단체 총연합회 '연탄나눔 봉사활동' 이웃사랑 실천 <b>부산광역시<\/b> 의료기사단체 총연합회가 ‘연탄나눔 봉사활동’을 시행해 지역사회에 따뜻한 행복을 전하고자 힘쓰고 있다. 이번 봉사활동은 어려운... ",
      //       "pubDate": "Mon, 20 Nov 2023 13:22:00 +0900"
      //     },
      //     {
      //       "title": "‘더 비치 푸르지오 써밋’ 20일 청약통장 없이 임의 공급 청약 진행",
      //       "originallink": "https:\/\/view.asiae.co.kr\/article\/2023112013144950787",
      //       "link": "https:\/\/n.news.naver.com\/mnews\/article\/277\/0005343222?sid=101",
      //       "description":
      //           "<b>부산광역시<\/b> 남구 일원에 공급되는 ‘더 비치 푸르지오 써밋’이 잔여 세대 30세대를 청약홈 임의공급(무순위)을 통하여 분양한다. 오는 12월 입주 예정인 ‘더 비치 푸르지오 써밋’은 20일 청약 접수를 거쳐 23일 당첨자... ",
      //       "pubDate": "Mon, 20 Nov 2023 13:20:00 +0900"
      //     },
      //     {
      //       "title": "서면·고현면민들 &quot;국도를 지방도로 격하? 결사반대&quot;",
      //       "originallink":
      //           "https:\/\/www.ohmynews.com\/NWS_Web\/View\/at_pg.aspx?CNTN_CD=A0002979117&CMPT_CD=P0010&utm_source=naver&utm_medium=newsearch&utm_campaign=naver_news",
      //       "link": "https:\/\/n.news.naver.com\/mnews\/article\/047\/0002413210?sid=102",
      //       "description":
      //           "국도77호선이란 국도77호선은 <b>부산광역시<\/b>부터 경기도 파주시까지 1239.4km에 해당하는 전국에서 가장 긴 국도다. 그중 남해군을 지나는 구간은 고현면과 서면을 비롯해 남해읍, 이동면, 상주면, 미조면, 삼동면... ",
      //       "pubDate": "Mon, 20 Nov 2023 13:11:00 +0900"
      //     },
      //     {
      //       "title": "창원시, '환경·사회·경제' 조화 이루는 '지속가능 발전 기본전략 수립'",
      //       "originallink": "https:\/\/www.gukjenews.com\/news\/articleView.html?idxno=2858676",
      //       "link": "https:\/\/www.gukjenews.com\/news\/articleView.html?idxno=2858676",
      //       "description":
      //           "이번 환경교육도시 지정 공모에는 총 17곳의 지자체가 신청하여 최종 <b>부산광역시<\/b>, 제주특별자치도의 광역 2곳과 창원시, 수원시, 시흥시, 광명시, 통영시의 기초 6곳이 선정됐다. 환경교육도시로 지정된 창원시는 지정서와... ",
      //       "pubDate": "Mon, 20 Nov 2023 13:04:00 +0900"
      //     },
      //     {
      //       "title": "<b>부산<\/b> 해운대구, 경제인 초청 지역 발전 방안 논의",
      //       "originallink": "http:\/\/www.inews24.com\/view\/1656193",
      //       "link": "https:\/\/n.news.naver.com\/mnews\/article\/031\/0000789569?sid=102",
      //       "description":
      //           "<b>부산광역시<\/b> 해운대구가 지난 16일 아르피나 자스민홀에서 경제인 초청 간담회를 가졌다. 이날 간담회에는 장복만 동원개발 대표, 송규정 윈스틸 회장 등 19개 기업 대표가 참석했다. 간담회에서는 김성수 <b>부산광역시<\/b>... ",
      //       "pubDate": "Mon, 20 Nov 2023 12:57:00 +0900"
      //     },
      //     {
      //       "title": "<b>부산<\/b>연탄은행 아미동 지역 연탄나눔 진행",
      //       "originallink": "https:\/\/www.busan.com\/view\/busan\/view.php?code=2023112012483280012",
      //       "link": "https:\/\/n.news.naver.com\/mnews\/article\/082\/0001242539?sid=102",
      //       "description":
      //           "<b>부산<\/b>연탄은행은 지난 16일 <b>부산광역시<\/b> 서구 아미동 지역에서 에너지배려세대 연탄나눔을 해운대재향경우회자문위원회(김철환)와 함께 진행하였다. 이날 봉사활동는 오전 10시 30분부터 오후 1시까지 진행되었고... ",
      //       "pubDate": "Mon, 20 Nov 2023 12:52:00 +0900"
      //     },
      //     {
      //       "title": "<b>부산<\/b>관광 브랜드스토어 현지 운영으로 중국·동남아 개별관광객 공략 나서",
      //       "originallink": "https:\/\/www.busan.com\/view\/busan\/view.php?code=2023112012421687147",
      //       "link": "https:\/\/n.news.naver.com\/mnews\/article\/082\/0001242541?sid=102",
      //       "description":
      //           "<b>부산광역시<\/b>(이하 <b>부산<\/b>시), <b>부산<\/b>관광공사(이하 공사)는 중국, 태국, 말레이시아 잠재관광객을 대상으로 <b>부산<\/b>의 매력을 널리 알리기 위한 <b>부산<\/b>관광 브랜드스토어를 현지에서 운영할 예정이다. 이번 행사는 <b>부산<\/b> 도시... ",
      //       "pubDate": "Mon, 20 Nov 2023 12:52:00 +0900"
      //     },
      //     {
      //       "title": "조명우, 정예성 꺾고 대한체육회장배 전국당구대회 우승",
      //       "originallink": "http:\/\/www.maniareport.com\/view.php?ud=202311201232589203bf6415b9ec_19",
      //       "link": "https:\/\/sports.news.naver.com\/news.nhn?oid=425&aid=0000145452",
      //       "description":
      //           "조명우는 8강전에서 강자인(충남체육회)을 만나 50:44로 누르며 준결승에 진출했고, 준결승전에서는 <b>부산광역시<\/b>체육회 김민석을 맞아 32이닝 끝에 50:32로 꺾고 결승에 먼저 안착했다. 정예성은 8강전에 김행직... ",
      //       "pubDate": "Mon, 20 Nov 2023 12:34:00 +0900"
      //     },
      //     {
      //       "title": "[아유경제_재건축] 산정수영 소규모재건축, 시공자 현설에 4개 사 '집합'",
      //       "originallink": "http:\/\/www.areyou.co.kr\/news\/articleView.html?idxno=80189",
      //       "link": "http:\/\/www.areyou.co.kr\/news\/articleView.html?idxno=80189",
      //       "description":
      //           "<b>부산광역시<\/b> 산정ㆍ수영아파트(이하 산정수영) 소규모재건축사업이 시공자 선정을 향해 순항하고 있다. 지난 16일 산정수영 소규모재건축 조합(조합장 김일균)은 오후 2시 조합 사무실에서 시공자 선정을 위한... ",
      //       "pubDate": "Mon, 20 Nov 2023 12:22:00 +0900"
      //     },
      //     {
      //       "title": "[아유경제_재건축] 남천백산 소규모재건축, 시공자 현설 방문 '5개 사'",
      //       "originallink": "http:\/\/www.areyou.co.kr\/news\/articleView.html?idxno=80190",
      //       "link": "http:\/\/www.areyou.co.kr\/news\/articleView.html?idxno=80190",
      //       "description":
      //           "<b>부산광역시<\/b> 남천동 백산아파트(이하 ) 소규모재건축사업의 시공자 선정을 향한 기대감이 높아지고 있다. 지난 16일 소규모재건축 조합(조합장 이종국)은 오후 2시 30분 조합 사무실에서 시공자 선정을 위한 현장설명회... ",
      //       "pubDate": "Mon, 20 Nov 2023 12:14:00 +0900"
      //     }
      //   ]
      // });

      for (var item in newsDTO.items) {
        String replaceTitle = item.title.replaceAll(RegExp(r'<b>|<\/b>|&quot;|&gt;'), '');
        String replaceDescription = item.description.replaceAll(RegExp(r'<b>|<\/b>|&quot;|&gt;'), '');
        item.title = replaceTitle;
        item.description = replaceDescription;
        String replaceTitle2 = item.title.replaceAll(RegExp('&amp;'), '&');
        String replaceDescription2 = item.description.replaceAll(RegExp('&amp;'), '&');
        item.title = replaceTitle2;
        item.description = replaceDescription2;
      }

      newsDTO.items.sort((a, b) {
        if (a.description.contains(where) && !b.description.contains(where)) {
          return -1; // a를 더 앞으로
        } else if (!a.description.contains(where) && b.description.contains(where)) {
          return 1; // b를 더 앞으로
        } else {
          return 0; // 나머지는 title을 기준으로 정렬
        }
      });

      newsDTO.items.sort((a, b) {
        if (a.title.contains(where) && !b.title.contains(where)) {
          return -1; // a를 더 앞으로
        } else if (!a.title.contains(where) && b.title.contains(where)) {
          return 1; // b를 더 앞으로
        } else {
          return 0; // 나머지는 title을 기준으로 정렬
        }
      });

      return new ResponseDTO(1, "성공", newsDTO);
    } catch (e) {
      return new ResponseDTO(-1, "실패", null);
    }
  }
}
