import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:beautiful_soup_dart/beautiful_soup.dart';
//import 'package:flutter_search_bar/flutter_search_bar.dart';

class SearchAndFindScreen extends StatefulWidget {
  const SearchAndFindScreen({Key? key}) : super(key: key);

  @override
  State<SearchAndFindScreen> createState() => _SearchAndFindScreenState();
}

var values = []; // bu mesajdir 2

class _SearchAndFindScreenState extends State<SearchAndFindScreen> {
  @override
  Future findurlhtml(String url_1, String website) async {
    //print(url_1);
    Uri url = Uri.parse(url_1); //deneme2
    //print(url.toString());
    try {
      http.Response response = await http.get(url);
      print(response.statusCode);
      //print(response.body);
      if (response.statusCode == 200) {
        //print("basarili");
        //print(response.body);
        String htmlToParse = response.body;
        //print(htmlToParse);
        //print(response.body);
        BeautifulSoup bs = BeautifulSoup(htmlToParse);
        //final name = bs.findAll('span', id: "productTitle");
        if (website == "kitapyurdu") {
          final name = bs.findAll('span', class_: 'value');
          values.add("Kitap Yurdu Fiyatı: " +
              name
                  .toString()
                  .split('<span class="value"><span class="TL"></span> ')[2]
                  .split('</span>')[0]);
          setState(() {});
        } else if (website == "ucuzkitapal") {
          final name = bs.findAll('span', class_: 'ty-price-num');
          values.add("Ucuz Kitap Al Fiyatı: " +
              name.toString().split('class="ty-price-num">')[1].split('<')[0]);
        } else if (website == "kidega") {
          //print(htmlToParse.split('class="waw-content-basket"'));
          final name = bs.findAll('div',
              id: 'ctl00_u10_ascArama_urun_ascUrunList_rptDestUrun_ctl00_pnlIndirim');
          //print(name.toString().split('class="urunListe_satisFiyat">')[1].split('<span')[0]);
          //print(name.toString().split('<span class="d">')[1].split('<')[0]);
          values.add("Kidega Fiyatı: " +
              name
                  .toString()
                  .split('class="urunListe_satisFiyat">')[1]
                  .split('<span')[0] +
              name.toString().split('<span class="d">')[1].split('<')[0]);
          setState(() {});
        }
      } else {
        print("1");
        return 'failed';
      }
    } catch (e) {
      print("2");
      return 'failed';
    }
  }

  Icon customIcon = const Icon(Icons.search);

  Widget customSearchBar =
      const Text('Lütfen arama yapıcağınız kitabın adını yazınız');

  final searchText = new TextEditingController();

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: customSearchBar,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              color: Colors.black45,
              onPressed: () {
                setState(() {
                  if (customIcon.icon == Icons.search) {
                    customIcon = const Icon(Icons.cancel);
                    customSearchBar = ListTile(
                      leading: const Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 28,
                      ),
                      title: TextField(
                        controller: searchText,
                        onEditingComplete: () {
                          print("yazilan ${searchText.text}");
                          var search_split = searchText.text.split(" ");
                          var search_value_kitapyurdu =
                              "https://www.kitapyurdu.com/index.php?route=product/search&filter_name=" +
                                  search_split.join("%20");
                          var search_value_ucuzkitapal =
                              "https://www.ucuzkitapal.com/ara/?search_performed=Y&q=" +
                                  search_split.join("+") +
                                  "&security_hash=78312b0da02d0a29508674bc23af1313";
                          var search_value_kidega =
                              "https://kidega.com/arama/" +
                                  search_split.join("+") +
                                  "/";

                          findurlhtml(search_value_kitapyurdu, "kitapyurdu");
                          findurlhtml(search_value_ucuzkitapal, "ucuzkitapal");
                          findurlhtml(search_value_kidega,
                              "kidega"); //https://www.bkmkitap.com/arama?q=harry+potter
                          //findurlhtml(search_value_kitapsepeti, "kitapsepeti");
                          /*while (values.length == 0) {
                            print("please wait aq");
                          }*/
                          setState(() {});

                          searchText.text = "";
                        },
                        decoration: const InputDecoration(
                          hintText:
                              'Lütfen arama yapıcağınız kitabın adını yazınız',
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                          ),
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );
                  } else {
                    customIcon = const Icon(Icons.search);
                    customSearchBar = const Text(
                        'Lütfen arama yapıcağınız kitabın adını yazınız');
                  }
                });
              },
              icon: customIcon,
            ),
          ],
        ),
        body: Container(
          child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: values.length,
              itemBuilder: (context, i) {
                return Column(
                  children: [
                    Container(
                        height: 50,
                        color: Colors.amber,
                        child: Center(
                          child: Text(values[i]),
                        )),
                    Container(
                      height: 10,
                    )
                  ],
                ); //Text(values[i]);
              }),
        ),
      ),
    );
  }
}
