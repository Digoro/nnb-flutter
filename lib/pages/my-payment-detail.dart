import 'package:flutter/material.dart';
import 'package:nnb_flutter/models/payment.dart';
import 'package:nnb_flutter/widgets/divider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../services/util_service.dart';
import '../widgets/button.dart';

class MyPaymentDetailPage extends StatefulWidget {
  final Payment? payment;

  const MyPaymentDetailPage({Key? key, required this.payment}) : super(key: key);

  @override
  State<MyPaymentDetailPage> createState() => _MyPaymentDetailPageState();
}

class _MyPaymentDetailPageState extends State<MyPaymentDetailPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        toolbarHeight: 60,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('결제 상세', style: TextStyle(color: Colors.black)),
          ],
        ),
      ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getBox([
                Row(
                  children: [
                    Image.network(widget.payment?.order?.product?.representationPhotos[0].photo ?? '', width: 100, height: 100),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.payment?.order?.product?.title ?? '', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ],
                )
              ]),
              getBox([
                Row(children: [
                  Expanded(
                      child: Button(
                          label: '실시간 카카오톡 문의',
                          onPressed: () {
                            launchUrl(
                              Uri.parse('https://nonunbub.com/host'),
                              mode: LaunchMode.externalApplication,
                            );
                          }))
                ])
              ]),
              NDivider(),
              if (widget.payment?.paymentCancel != null)
                getBox([
                  Text('결제 취소 정보', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  SizedBox(height: 10),
                  Text('취소 일시: ${getDateTime(widget.payment?.paymentCancel?.cancelAt)}'),
                  Text('환불 금액: ${widget.payment?.paymentCancel?.refundPrice}원'),
                  Text('쿠폰 환불 여부: ${widget.payment?.paymentCancel?.refundCoupon != null ? '환불' : '환불 X'}'),
                  Text('포인트 환불 여부: ${widget.payment?.paymentCancel?.refundPoint != null ? '환불' : '환불 X'}'),
                  Text('취소 사유: ${widget.payment?.paymentCancel?.reason}'),
                ]),
              if (widget.payment?.paymentCancel != null) NDivider(),
              getBox([
                Text('결제 정보', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                SizedBox(height: 10),
                Text('주문 번호: ${widget.payment?.id}'),
                Text('결제 일시: ${getDateTime(widget.payment?.payAt)}'),
                Text('결제 금액: ${widget.payment?.payPrice}원'),
              ]),
              NDivider(),
              getBox([
                Text('구매 옵션', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                SizedBox(height: 10),
                if (widget.payment?.order?.orderItems != null)
                  ...?widget.payment?.order?.orderItems
                      ?.map((item) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('옵션: ${item.productOption.name}'),
                              Text('시작일: ${getDateTime(item.productOption.date)}'),
                              Text('가격: ${item.productOption.price}원'),
                              Text('수량: ${item.count}개'),
                              if (widget.payment!.order!.orderItems!.length > 1) Divider()
                            ],
                          ))
                      .toList(),
              ]),
              NDivider(),
              if (widget.payment?.order?.point != null && widget.payment?.order?.point != 0 && widget.payment?.order?.coupon != null)
                getBox([
                  Text('포인트/쿠폰', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  SizedBox(height: 10),
                  if (widget.payment?.order?.point != null && widget.payment?.order?.point != 0) Text('포인트: ${widget.payment?.order?.point}원'),
                  Text('쿠폰: ${widget.payment?.order?.coupon?.name}(${widget.payment?.order?.coupon?.price}원)'),
                ])
            ],
          )
        ],
      ),
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
