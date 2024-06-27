import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jd_shop/services/ScreenAdapter.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  @override
  SearchPageState createState() {
    return SearchPageState();
  }
}

class SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Container(
            child: TextField(
              autofocus: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(30))),
            ),
            height: ScreenAdapter.height(68),
            decoration: BoxDecoration(
                color: Color.fromRGBO(233, 233, 233, 0.8),
                borderRadius: BorderRadius.circular(30)),
          ),
          actions: [
            InkWell(
              child: Container(
                height: ScreenAdapter.height(68),
                width: ScreenAdapter.height(80),
                child: Row(
                  children: [Text("搜索")],
                ),
              ),
              onTap: () {},
            )
          ],
        ),
        body: Container(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: [
                Container(
                  child: Text(
                    "热搜",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Divider(),
                Wrap(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(233, 233, 233, 0.9),
                          borderRadius: BorderRadius.circular(10)),
                      child: Text("test"),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  child: Text(
                    "历史记录",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Divider(),
                Column(
                  children: [
                    ListTile(
                      title: Text("test"),
                    ),
                    Divider(),
                  ],
                ),
                SizedBox(
                  height: 100,
                ),
                InkWell(
                  child: Container(
                      width: ScreenAdapter.width(500),
                      height: ScreenAdapter.height(64),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Color.fromRGBO(233, 233, 233, 0 / 9),
                              width: 1)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.delete),
                          Text("清空历史记录"),
                        ],
                      )),
                  onTap: () {
                    
                  },
                )
              ],
            )));
  }
}
