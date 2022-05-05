import 'package:flutter/material.dart';
import 'package:nnb_flutter/models/payment.dart';
import 'package:nnb_flutter/pages/product_detail_page.dart';
import 'package:nnb_flutter/services/product_service.dart';
import '../models/product.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  List<dynamic> newProducts = [];
  List<dynamic> bestProducts = [];
  List<dynamic> womenProducts = [];
  List<dynamic> travelProducts = [];
  GlobalKey newProductsKey = GlobalKey();
  GlobalKey bestProductsKey = GlobalKey();
  GlobalKey womenProductsKey = GlobalKey();
  GlobalKey travelProductsKey = GlobalKey();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    setProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 60,
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/nnblogo.png',
              fit: BoxFit.cover,
              height: 40,
              width: 40,
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => setProducts(),
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(width: 5),
                  homeMenuButton('#새롭게 열린', newProductsKey),
                  SizedBox(width: 5),
                  homeMenuButton('#주간 BEST', bestProductsKey),
                  SizedBox(width: 5),
                  homeMenuButton('#라이프스타일', womenProductsKey),
                  SizedBox(width: 5),
                  homeMenuButton('#떠나고 싶을때', travelProductsKey),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                        child: Text('새롭게 열린 모임', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), key: newProductsKey),
                      ),
                      ...newProducts.map((e) => productWidget(e, context)).toList(),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                        child: Text('주간 BEST 모임!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), key: bestProductsKey),
                      ),
                      ...bestProducts.map((e) => productWidget(e, context)).toList(),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                        child: Text('문득 떠나고 싶을때', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), key: travelProductsKey),
                      ),
                      ...travelProducts.map((e) => productWidget(e, context)).toList(),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                        child: Text('4050 여성들의 라이프스타일', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), key: womenProductsKey),
                      ),
                      ...womenProducts.map((e) => productWidget(e, context)).toList(),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  setProducts() async {
    var newData = await getProducts({
      "page": 1,
      "limit": 9999,
      "status": "오픈중",
      "analysisHashtags": ["new"]
    });
    var bestData = await getProducts({
      "page": 1,
      "limit": 9999,
      "status": "오픈중",
      "analysisHashtags": ["best"]
    });
    var travelData = await getProducts({
      "page": 1,
      "limit": 9999,
      "status": "오픈중",
      "categoryIds": [1]
    });
    var womenData = await getProducts({
      "page": 1,
      "limit": 9999,
      "status": "오픈중",
      "categoryIds": [6, 7, 8, 9, 10, 11, 12]
    });

    setState(() {
      newProducts = newData;
      bestProducts = bestData;
      travelProducts = travelData;
      womenProducts = womenData;
    });
  }
}

homeMenuButton(String label, GlobalKey key) {
  return OutlinedButton(
    child: Text(label, style: TextStyle(color: Colors.black)),
    style: OutlinedButton.styleFrom(
      padding: EdgeInsets.fromLTRB(7, 0, 7, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
    onPressed: () => {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      ),
    },
  );
}

productWidget(Product product, BuildContext context) {
  var images = (product.orders as List<Order>)
      .where((order) => order.user != null && order.payment?.paymentCancel == null)
      .map((order) => (order.user?.profilePhoto) as String)
      .toList()
      .reversed
      .toSet()
      .take(8)
      .toList();
  return Column(
    children: [
      GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => {
          Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailPage(productId: product.id))),
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(product.representationPhotos[0].photo, width: 90, height: 90),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.title),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Stack(children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(product.representationPhotos[0].photo, width: 34, height: 34, fit: BoxFit.cover),
                          ),
                          ...images
                              .asMap()
                              .map(
                                (index, image) => MapEntry(
                                    index,
                                    Positioned(
                                      left: 24.0 * index,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(100),
                                        child: Image.network(image, width: 34, height: 34, fit: BoxFit.cover),
                                      ),
                                    )),
                              )
                              .values
                              .toList(),
                        ]),
                      ),
                      Row(children: [
                        Icon(Icons.favorite_outline, size: 13),
                        Text('${product.likes}', style: TextStyle(fontSize: 13)),
                      ])
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      Divider(
        thickness: 0.5,
        color: Color.fromARGB(255, 187, 187, 187),
        height: 25,
      )
    ],
  );
}
