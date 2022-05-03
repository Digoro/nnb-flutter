import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/product.dart';
import '../widgets/button.dart';

class PaymentSelectPage extends StatefulWidget {
  final Product product;
  PaymentSelectPage({Key? key, required this.product}) : super(key: key);

  @override
  State<PaymentSelectPage> createState() => _PaymentSelectPageState();
}

class Event {
  String title;
  bool complete;
  Event(this.title, this.complete);

  @override
  String toString() => title;
}

class _PaymentSelectPageState extends State<PaymentSelectPage> {
  Map<DateTime, dynamic> eventSource = {
    DateTime.utc(2022, 4, 3): [Event('5분 기도하기', false), Event('교회 가서 인증샷 찍기', true), Event('QT하기', true), Event('셀 모임하기', false)],
    DateTime.utc(2022, 4, 5): [Event('5분 기도하기', false), Event('치킨 먹기', true), Event('QT하기', true), Event('셀 모임하기', false)],
    DateTime.utc(2022, 4, 8): [Event('5분 기도하기', false), Event('자기 셀카 올리기', true), Event('QT하기', false), Event('셀 모임하기', false)],
    DateTime.utc(2022, 4, 11): [Event('5분 기도하기', false), Event('가족과 저녁식사 하기', true), Event('QT하기', true)],
    DateTime.utc(2022, 4, 13): [Event('5분 기도하기', false), Event('교회 가서 인증샷 찍기', true), Event('QT하기', false), Event('셀 모임하기', false)],
    DateTime.utc(2022, 4, 15): [Event('5분 기도하기', false), Event('치킨 먹기', false), Event('QT하기', true), Event('셀 모임하기', false)],
    DateTime.utc(2022, 4, 18): [Event('5분 기도하기', false), Event('자기 셀카 올리기', true), Event('QT하기', false), Event('셀 모임하기', false)],
    DateTime.utc(2022, 4, 20): [Event('5분 기도하기', true), Event('자기 셀카 올리기', true), Event('QT하기', true), Event('셀 모임하기', true)],
    DateTime.utc(2022, 4, 21): [Event('5분 기도하기', false), Event('가족과 저녁식사 하기', true), Event('QT하기', false)]
  };

  List<Event> getEventsForDay(DateTime day) {
    if (eventSource[day] != null) {
      return eventSource[day];
    } else {
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 60,
        elevation: 1,
        title: Text('모임 일정 선택', style: TextStyle(color: Colors.black)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: TableCalendar(
          locale: 'ko-KR',
          firstDay: DateTime.utc(2021, 1, 1),
          lastDay: DateTime.utc(2030, 1, 1),
          focusedDay: DateTime.now(),
          headerStyle: HeaderStyle(
            headerMargin: EdgeInsets.only(left: 40, right: 40, bottom: 10),
            titleCentered: true,
            formatButtonVisible: false,
          ),
          eventLoader: (day) {
            return getEventsForDay(day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            print(selectedDay);
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Button(label: '결제하러 가기!', type: 'primary', onPressed: () {}),
        ),
      ),
    );
  }
}
