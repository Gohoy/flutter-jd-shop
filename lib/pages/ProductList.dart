import 'package:flutter/material.dart';
import 'package:jd_shop/services/ScreenAdapter.dart';

class ProductListPage extends StatefulWidget {
  final Map arguments;

  const ProductListPage({super.key, required this.arguments});

  @override
  ProduListPageState createState() {
    return ProduListPageState();
  }
}

class ProduListPageState extends State<ProductListPage> {
  @override
  Widget build(BuildContext context) {
    ScreenAdapter().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("商品列表"),
      ),
      // body: Text("${widget.arguments}"),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(itemBuilder: (context, index) {
          return Column(
            children: [
              Row(
                children: [
                  Container(
                    width: ScreenAdapter.width(180),
                    height: ScreenAdapter.height(180),
                    child: Image.network(
                      "https://www.loliapi.com/acg/pc",
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
                          const Text(
                            "name",
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
                          const Text(
                            "price",
                            style: TextStyle(color: Colors.brown),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const Divider(
                height: 1,
              )
            ],
          );
        }),
      ),
    );
  }
}
