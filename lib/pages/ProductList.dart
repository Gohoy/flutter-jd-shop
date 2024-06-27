import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jd_shop/config/config.dart';
import 'package:jd_shop/model/ProductModel.dart';
import 'package:jd_shop/services/ScreenAdapter.dart';
import 'package:jd_shop/widget/LoadingWidget.dart';

class ProductListPage extends StatefulWidget {
  final Map arguments;

  const ProductListPage({super.key, required this.arguments});

  @override
  ProduListPageState createState() {
    return ProduListPageState();
  }
}

class ProduListPageState extends State<ProductListPage> {
  ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _getProductListData();
    // 监听滚动事件
    _scrollController.addListener(() {
      // 获取滚动条滚动的高度
      // _scrollController.position.pixels;
      // 获取页面高度
      // _scrollController.position.maxScrollExtent;
      if (_scrollController.position.pixels >
              _scrollController.position.maxScrollExtent - 20 &&
          _hasMore) {
        if (flag) {
          print("api request");
          _getProductListData();
        }
      }
    });
  }

  int _page = 1;
  int _pageSize = 8;
  String _sort = "";
  List _productData = [];
  bool flag = true;
  bool _hasMore = true;
  final List _subHeaderList = [
    {"id": 0, "title": "综合", "fields": "all", "sort": -1},
    {"id": 1, "title": "销量", "fields": "salecount", "sort": -1},
    {"id": 2, "title": "价格", "fields": "price", "sort": -1},
    {"id": 3, "title": "筛选"}
  ];
  int selectedId = 1;

  Widget _showMore(index) {
    if (_hasMore) {
      return (index == _productData.length - 1 && _hasMore)
          ? const Loadingwidget()
          : const Text("");
    } else {
      return (index == _productData.length - 1)
          ? const Text("我是有底线的")
          : const Text("");
    }
  }

  _getProductListData() async {
    setState(() {
      flag = false;
    });
    //排序query
    var api =
        '${Config.baseUrl}/plist?cid=${widget.arguments["cid"]}&page=$_page&pageSize=$_pageSize&sort=$_sort&sort=$_sort';
    var result = await Dio().get(api);
    var productList = ProductModel.fromJson(result.data);

    if (productList.result!.length < _pageSize) {
      _hasMore = false;
    }
    setState(() {
      _productData.addAll(productList.result!);
      _page++;
      flag = true;
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Widget _productListWidget() {
    if (_productData.isNotEmpty) {
      return Container(
        margin: EdgeInsets.only(top: ScreenAdapter.height(80)),
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          controller: _scrollController,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: ScreenAdapter.width(180),
                      height: ScreenAdapter.height(180),
                      child: Image.network(
                        // "https://www.loliapi.com/acg/pc",
                        _productData[index].pic,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(left: ScreenAdapter.width(10)),
                        height: ScreenAdapter.height(180),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _productData[index].title,
                              // "name",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              children: [
                                Container(
                                  height: ScreenAdapter.height(36),
                                  margin: const EdgeInsets.only(right: 10),
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  //container中有BoxDecoration的时候,color必须放到 BoxDecoration中,否则会报错
                                  decoration: BoxDecoration(
                                      color: const Color.fromRGBO(
                                          230, 230, 230, 0.9),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Text("category"),
                                ),
                              ],
                            ),
                            Text(
                              '${_productData[index].price}',
                              style: const TextStyle(color: Colors.brown),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const Divider(
                  height: 1,
                ),
                _showMore(index),
              ],
            );
          },
          itemCount: _productData.length,
        ),
      );
    } else {
      return const Loadingwidget();
    }
  }

//导航
  Widget _subHeaderWidget() {
    return Positioned(
        top: 0,
        height: ScreenAdapter.height(80),
        width: ScreenAdapter.width(750),
        child: Container(
          height: ScreenAdapter.height(80),
          width: ScreenAdapter.width(750),
          decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: 1, color: Color.fromRGBO(233, 233, 233, 0.9)))),
          child: Row(
              children: _subHeaderList.map((value) {
            return Expanded(
                flex: 1,
                child: InkWell(
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(0, ScreenAdapter.height(16),
                          0, ScreenAdapter.height(16)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${value["title"]}",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: (selectedId == value["id"])
                                    ? Colors.red
                                    : Colors.black54),
                          ),
                          value["id"] == 1 || value["id"] == 2
                              ? (Icon(value["sort"] == -1
                                  ? Icons.arrow_drop_down
                                  : Icons.arrow_drop_up))
                              : Text(""),
                        ],
                      )),
                  onTap: () {
                    if (value["id"] == 3) {
                      _scaffoldKey.currentState!.openEndDrawer();
                      setState(() {
                        selectedId = value["id"];
                      });
                    } else {
                      setState(() {
                        selectedId = value["id"];
                        _sort = value["fields"] + "$value['sort']";
                        _page = 1;
                        _productData = [];
                        _scrollController.jumpTo(0);
                        _hasMore = true;
                        _subHeaderList[value["id"]]["sort"] *= -1;
                        print(_subHeaderList[selectedId]["sort"]);
                        _getProductListData();
                      });
                    }
                  },
                ));
          }).toList()),
        ));
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter().init(context);
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(title: const Text("商品列表"), actions: const [Text("")]),
        endDrawer: Drawer(
          child: Container(
            child: const Text("筛选"),
          ),
        ),

        // body: Text("${widget.arguments}"),
        body: Stack(children: [_productListWidget(), _subHeaderWidget()]));
  }
}
