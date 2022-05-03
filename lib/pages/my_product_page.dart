import 'package:flutter/material.dart';
import 'package:nnb_flutter/models/payment.dart';
import 'package:nnb_flutter/pages/my-payment-detail.dart';
import 'package:nnb_flutter/widgets/button.dart';
import '../services/payment_service.dart';

class MyProductPage extends StatefulWidget {
  const MyProductPage({Key? key}) : super(key: key);

  @override
  State<MyProductPage> createState() => _MyProductPageState();
}

class _MyProductPageState extends State<MyProductPage> {
  List<Payment?>? payments;

  @override
  void initState() {
    super.initState();
    getPurchasedPayments({"page": 1, "limit": 9999, "isLast": true}).then((value) {
      setState(() {
        payments = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          toolbarHeight: 60,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.black,
            onPressed: () => Navigator.pop(context),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text('참여한 모임', style: TextStyle(color: Colors.black)),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: payments?.map((payment) {
                  return getProduct(payment, context);
                }).toList() ??
                [],
          ),
        ));
  }
}

Widget getProduct(Payment? payment, BuildContext context) {
  var row = Column(children: [
    Row(
      children: [
        Image.network(
          payment?.order?.product?.representationPhotos[0].photo ?? '',
          width: 100,
          height: 100,
        ),
        SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (payment?.paymentCancel != null) Text('취소됨', style: TextStyle(fontWeight: FontWeight.bold)),
              Text(payment?.order?.product?.title ?? '', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 3),
              Text('총 결제 금액: ${payment?.payPrice}원'),
              SizedBox(height: 3),
              Row(
                children: [
                  Button(
                      label: '결제 상세보기',
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => MyPaymentDetailPage(payment: payment)));
                      })
                ],
              )
            ],
          ),
        ),
      ],
    ),
    Divider()
  ]);
  return row;
}
