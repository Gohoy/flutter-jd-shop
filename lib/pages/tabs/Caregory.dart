import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jd_shop/config/config.dart';
import 'package:jd_shop/model/CategoryModel.dart';
import 'package:jd_shop/services/ScreenAdapter.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});
  @override
  CategoryPageState createState() {
    return CategoryPageState();
  }
}

class CategoryPageState extends State<CategoryPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  var _selectedIndex = 0;

  List _leftCataData = [];
  List _rightCataData = [];
  @override
  void initState() {
    super.initState();
    _getLeftCataData();
  }

  _getLeftCataData() async {
    var api = '${Config.baseUrl}/getCategory';
    var result = await Dio().get(api);
    var leftCataList = CategoryModel.fromJson(result.data);
    setState(() {
      _leftCataData = leftCataList.result!;
    });
    // 这里模拟通过id 获取,实际上id没有使用
    _getRightCataData("1");
  }

  _getRightCataData(id) async {
    var api = '${Config.baseUrl}/getCategory';
    var result = await Dio().get(api);
    var rigthCataList = CategoryModel.fromJson(result.data);
    setState(() {
      _rightCataData = rigthCataList.result!;
    });
  }

  Widget _leftCateWidget(leftWidth) {
    if (_leftCataData.isNotEmpty) {
      return Container(
          height: double.infinity,
          width: leftWidth,
          child: ListView.builder(
              itemCount: _leftCataData.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          _selectedIndex = index;
                          _getRightCataData(_leftCataData[index].pid);
                        });
                      },
                      child: Container(
                        width: double.infinity,
                        height: ScreenAdapter.height(84),
                        padding: EdgeInsets.only(top: ScreenAdapter.height(24)),
                        color: _selectedIndex == index
                            ? const Color.fromRGBO(240, 246, 246, 0.9)
                            : Colors.white,
                        child: Text(
                          "${_leftCataData[index].title}",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const Divider(
                      height: 1,
                    ),
                  ],
                );
              }));
    } else {
      return Container(
        width: leftWidth,
        height: double.infinity,
      );
    }
  }

  Widget _rightCateWidget(rigthItemWidth, rigthItemHeight) {
    if (_rightCataData.isNotEmpty) {
      return Expanded(
        flex: 1,
        child: Container(
            padding: const EdgeInsets.all(10),
            height: double.infinity,
            color: const Color.fromRGBO(240, 246, 246, 0.9),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: rigthItemWidth / rigthItemHeight,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
              itemCount: _rightCataData.length,
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/productList',
                          arguments: <String, String>{
                            "cid": "${_rightCataData[index].sId}"
                          });
                    },
                    child: Container(
                      child: Column(
                        children: [
                          AspectRatio(
                            aspectRatio: 1 / 1,
                            child: Image.network(
                              // "https://www.loliapi.com/acg/pc",
                              "${_rightCataData[index].pic}",
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            height: ScreenAdapter.height(28),
                            child: Text("${_rightCataData[index].title}"),
                          )
                        ],
                      ),
                    ));
              },
            )),
      );
    } else {
      return Expanded(
        flex: 1,
        child: Container(
          padding: const EdgeInsets.all(10),
          height: double.infinity,
          color: const Color.fromRGBO(240, 246, 246, 0.9),
          child: const Text("loading"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    ScreenAdapter().init(context);

// 计算右侧GridView宽高比
    var leftWidth = ScreenAdapter.getScreenWidth() / 4;
    // 右侧宽度= 总宽度- 左侧 -GridView 外层元素左右padding值 - GrideView中间的间距
    var rigthItemWidth =
        (ScreenAdapter.getScreenWidth() - leftWidth - 20 - 20) / 3;
    rigthItemWidth = ScreenAdapter.width(rigthItemWidth);
    var rigthItemHeight = rigthItemWidth + ScreenAdapter.height(28);

    return Row(
      children: [
        _leftCateWidget(leftWidth),
        _rightCateWidget(rigthItemWidth, rigthItemHeight)
      ],
    );
  }
}
