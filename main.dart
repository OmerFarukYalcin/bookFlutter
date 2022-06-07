import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:beautiful_soup_dart/beautiful_soup.dart';
//import 'package:flutter_search_bar/flutter_search_bar.dart';
import 'package:web_scaring/main_screen.dart';

void main() {
  runApp(const SearchAndFindScreen());
}
/*
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: 'Lütfen arama yapıcağınız kitabın adını yazınız',
      home: const MyHomePage(),
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(child: Container()));
  }
}

Future<String> findurlhtml() async {
  print('fonksiyonda');
  var url = Uri.parse(
      'https://www.amazon.com.tr/K%C4%B1z%C4%B1l-Veba-Jack-London/dp/6257070783/ref=sr_1_1?qid=1648393518&refinements=p_27%3A-&s=books&sr=1-1');
  http.Response response = await http.get(url);
  print("buldu");
  try {
    if (response.statusCode == 200) {
      String htmlToParse = response.body;
      //print(htmlToParse);
      //print(response.body);
      BeautifulSoup bs = BeautifulSoup(htmlToParse);
      final name = bs.findAll('span', id: "productTitle");
      //String name_str = name.toString();
      name.forEach((element) {
        print('the header: ${element.text}');
      });
      //});
      print(name);
    } else {
      return 'failed';
    }
  } catch (e) {
    return 'failed';
  }
  return 'asdaw';
}*/
