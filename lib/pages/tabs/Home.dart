import 'package:card_swiper/card_swiper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jd_shop/config/config.dart';
import 'package:jd_shop/model/FocusModel.dart';
import 'package:jd_shop/model/ProductModel.dart';
import 'package:jd_shop/services/ScreenAdapter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  HomePageState createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  List _focusData = [];
  List _hotProductData = [];
  List _bestProductData = [];
  @override
  void initState() {
    super.initState();
    _getFocusData();
    _getHotProductData();
    _getBestProductData();
  }

// 获取轮播图

  _getFocusData() async {
    var api = "${Config.baseUrl}/getFocus";
    var result = await Dio().get(api);
    var focusList = FocusModel.fromJson(result.data);
    setState(() {
      _focusData = focusList.result!;
    });
  }

  // 获取猜你喜欢
  _getHotProductData() async {
    var api = '${Config.baseUrl}/plist';
    var result = await Dio().get(api);
    var hotProductList = ProductModel.fromJson(result.data);

    setState(() {
      _hotProductData = hotProductList.result!;
    });
  }

  // 获取热门商品
  _getBestProductData() async {
    var api = '${Config.baseUrl}/plist';
    var result = await Dio().get(api);
    var bestProductList = ProductModel.fromJson(result.data);

    setState(() {
      _bestProductData = bestProductList.result!;
    });
  }

  Widget _swiperWidget() {
    if (_focusData.isNotEmpty) {
      // print(_focusData);
      // List<Map> imgList = [
      //   {
      //     "url": "https://www.loliapi.com/acg/pc/",
      //   },
      //   {
      //     "url": "https://www.loliapi.com/acg/pc",
      //   },
      //   {
      //     "url": "https://www.loliapi.com/acg/pc",
      //   },
      // ];
      return AspectRatio(
        aspectRatio: 2 / 1,
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return Image.network(
              _focusData[index].url,
              fit: BoxFit.fill,
            );
          },
          itemCount: _focusData.length,
          pagination: const SwiperPagination(),
          autoplay: true,
        ),
      );
    } else {
      return const Text("loading");
    }
  }

  Widget _titleWidget(value) {
    return Container(
      height: ScreenAdapter.height(32),
      margin: EdgeInsets.only(left: ScreenAdapter.width(20)),
      padding: EdgeInsets.only(left: ScreenAdapter.width(20)),
      decoration: BoxDecoration(
          border: Border(
              left: BorderSide(
                  color: Colors.red, width: ScreenAdapter.width(10)))),
      child: Text(
        value,
        style: const TextStyle(color: Colors.black54),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    ScreenUtil.init(context, designSize: const Size(750, 1334));
    return ListView(
      children: <Widget>[
        _swiperWidget(),
        SizedBox(
          height: ScreenAdapter.height(10),
        ),
        _titleWidget("猜你喜欢"),
        _hotProductListWidget(),
        SizedBox(
          height: ScreenAdapter.height(10),
        ),
        _titleWidget("热门推荐"),
        bestProductWidget(),
      ],
    );
  }

  Widget bestProductWidget() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Wrap(
          runSpacing: 10,
          spacing: 10,
          children: _bestProductData
              .map((value) => _recProductListWidget(value))
              .toList()),
    );
  }

  Widget _recProductListWidget(value) {
    var itemWidth = (ScreenAdapter.getScreenWidth() - 30) / 2;

    return Container(
      padding: const EdgeInsets.all(5),
      width: itemWidth,
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromRGBO(233, 233, 233, 0.9),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          SizedBox(
              width: double.infinity,
              child: Image.network(value.pic
                  // "https://www.loliapi.com/acg/pc/",
                  )),
          Padding(
              padding: EdgeInsets.only(top: ScreenAdapter.height(15)),
              child: Text(
                // "loshiki",
                "${value.title}",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.black54),
              )),
          Padding(
              padding: EdgeInsets.only(top: ScreenAdapter.height(15)),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "\$${value.price}",
                      style: const TextStyle(color: Colors.red, fontSize: 16),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "\$${value.oldPrice}",
                      style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                          decoration: TextDecoration.lineThrough),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }

  Widget _hotProductListWidget() {
    if (_hotProductData.isNotEmpty) {
      return SizedBox(
        height: ScreenAdapter.height(200),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                    height: ScreenAdapter.height(140),
                    width: ScreenAdapter.width(140),
                    padding: EdgeInsets.all(ScreenAdapter.width(15)),
                    margin: EdgeInsets.only(right: ScreenAdapter.width(21)),
                    child: AspectRatio(
                      // make the photo to be same size
                      aspectRatio: 1 / 1,
                      child: Image.network(
                        "${_hotProductData[index].sPic}",
                        fit: BoxFit.cover,
                      ),
                    )),
                Container(
                  padding: EdgeInsets.only(top: ScreenAdapter.height(10)),
                  height: ScreenAdapter.height(44),
                  child: Text(
                    "${_hotProductData[index].price}",
                    style: const TextStyle(color: Colors.red),
                  ),
                )
              ],
            );
          },
          itemCount: _hotProductData.length,
        ),
      );
    } else {
      return const Text("正在加载");
    }
  }
}
