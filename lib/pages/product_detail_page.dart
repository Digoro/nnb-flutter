import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:intl/intl.dart';
import 'package:nnb_flutter/pages/home_page.dart';
import 'package:nnb_flutter/services/product_service.dart';
import 'package:nnb_flutter/widgets/button.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

import '../models/product.dart';
import '../widgets/divider.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({Key? key, required this.productId}) : super(key: key);

  final int productId;

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late ScrollController _scrollController;
  Color _textColor = Colors.black;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController()
      ..addListener(() {
        print('scroll');
        // setState(() {
        //   _textColor = _isSliverAppBarExpanded ? Colors.black : Colors.white;
        // });
      });
  }

  bool get _isSliverAppBarExpanded {
    return _scrollController.hasClients && _scrollController.offset > (200 - kToolbarHeight);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getProduct(widget.productId, null),
      builder: (BuildContext context, AsyncSnapshot<Product> snapshot) {
        if (snapshot.hasData) {
          var product = snapshot.data as Product;
          var runningDays = product.runningDays != 0 ? '${product.runningDays}일' : '';
          var runningHours = product.runningHours != 0 ? '${product.runningHours}시간' : '';
          var runningMinutes = product.runningMinutes != 0 ? '${product.runningMinutes}분' : '';
          var runningTime = '$runningDays$runningHours$runningMinutes 소요';

          dynamic descriptionKey = GlobalKey();
          dynamic addressKey = GlobalKey();
          dynamic infoKey = GlobalKey();
          dynamic hostKey = GlobalKey();

          return Scaffold(
            body: CustomScrollView(
              controller: _scrollController,
              slivers: <Widget>[
                SliverAppBar(
                  pinned: true,
                  snap: false,
                  floating: false,
                  expandedHeight: 320.0,
                  toolbarHeight: 40,
                  backgroundColor: Colors.white,
                  iconTheme: IconThemeData(color: _textColor),
                  elevation: 0.0,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  actions: [
                    IconButton(
                      icon: Icon(Icons.home_outlined),
                      onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage())),
                    ),
                    IconButton(
                      icon: Icon(Platform.isIOS ? Icons.ios_share_rounded : Icons.share_rounded),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: 'https://nonunbub.com/tabs/meeting-detail/${product.id}'));
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("링크가 복사되었습니다."),
                        ));
                      },
                    ),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                    background: ImageSlideshow(
                      width: double.infinity,
                      height: 320,
                      initialPage: 0,
                      indicatorColor: Colors.blue,
                      indicatorBackgroundColor: Colors.grey,
                      children: product.representationPhotos.map((e) => Image.network(e.photo, fit: BoxFit.cover)).toList(),
                      isLoop: false,
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          getBox([
                            SizedBox(height: 10),
                            Text(product.title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21, height: 1.3)),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                product.discountPrice == 0
                                    ? Text('${NumberFormat().format(product.price)}원', style: TextStyle(fontSize: 16))
                                    : Row(children: [
                                        Text('${NumberFormat().format(product.price)}원',
                                            style: TextStyle(fontSize: 14, decoration: TextDecoration.lineThrough)),
                                        SizedBox(width: 5),
                                        Text('${NumberFormat().format(product.discountPrice)}원', style: TextStyle(fontSize: 16)),
                                      ]),
                                Button(
                                  label: '공유하기',
                                  onPressed: () {
                                    Clipboard.setData(ClipboardData(text: 'https://nonunbub.com/tabs/meeting-detail/${product.id}'));
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      content: Text("링크가 복사되었습니다."),
                                    ));
                                  },
                                ),
                              ],
                            ),
                          ]),
                          NDivider(),
                          StickyHeader(
                            header: Padding(
                              padding: const EdgeInsets.only(top: 40),
                              child: Row(children: [
                                Expanded(
                                  child: Container(
                                    color: Colors.white,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          SizedBox(width: 15),
                                          homeMenuButton('모임 소개', descriptionKey),
                                          SizedBox(width: 5),
                                          homeMenuButton('모임 장소', addressKey),
                                          SizedBox(width: 5),
                                          homeMenuButton('모임 정보', infoKey),
                                          SizedBox(width: 5),
                                          homeMenuButton('호스트', hostKey),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 20, key: descriptionKey),
                                getBox([
                                  Text('체크 포인트!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                                  Html(data: product.checkList),
                                ]),
                                NDivider(),
                                getBox([
                                  Text('이런 분이 함께하면 좋아요!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                                  Html(data: product.recommend),
                                ]),
                                NDivider(),
                                getBox([
                                  Text('모임 소개', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                                  Html(data: product.description),
                                ]),
                                NDivider(),
                                getBox([
                                  Text('모임 장소', key: addressKey, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                                  SizedBox(height: 10),
                                  Text(product.address ?? ''),
                                  Text(product.detailAddress ?? ''),
                                ]),
                                NDivider(),
                                getBox([
                                  Text('모임 정보', key: infoKey, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                                  SizedBox(height: 10),
                                  Text('준비물', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                  Text(product.checkList),
                                  SizedBox(height: 10),
                                  Text('포함 사항', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                  Text(product.includeList),
                                  SizedBox(height: 10),
                                  Text('불포함 사항', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                  Text(product.excludeList),
                                  SizedBox(height: 10),
                                  Text('유의 사항', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                  Text(product.notice),
                                  SizedBox(height: 10),
                                  Text('환불 정책', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                  Text('상품 시작일 기준 ${product.refundPolicy100}일 전까지 100% 환불'),
                                  Text('상품 시작일 기준 ${product.refundPolicy0 + 1}일 전까지 50% 환불'),
                                  Text('상품 시작일 기준 ${product.refundPolicy0}일 전 이후 환불 불가'),
                                ]),
                                NDivider(),
                                getBox([
                                  Text('호스트', key: hostKey, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(100),
                                        child: Image.network(product.host?.profilePhoto ?? '', width: 45, height: 45, fit: BoxFit.cover),
                                      ),
                                      SizedBox(width: 10),
                                      Text(product.host?.nickname ?? '', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Text(product.host?.catchphrase ?? '', style: TextStyle(fontWeight: FontWeight.bold)),
                                  SizedBox(height: 10),
                                  Text(product.host?.introduction ?? ''),
                                ]),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                    childCount: 1,
                  ),
                ),
              ],
            ),
            bottomNavigationBar: BottomAppBar(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    IconButton(onPressed: () => {}, icon: Icon(Icons.favorite_outline)),
                    Expanded(
                      child: Button(label: '모임 일정 확인하기', type: 'primary', onPressed: () {}),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

getBox(List<Widget> children, {double padding = 10.0}) {
  return Padding(
    padding: EdgeInsets.all(padding),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    ),
  );
}
