import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nnb_flutter/widgets/card.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/product.dart';
import '../services/util_service.dart';
import '../widgets/button.dart';

class Event {
  DateTime dateTime;
  List<ProductOption> options;
  bool reservationEnd;

  Event(this.dateTime, this.options, this.reservationEnd);
}

class PaymentSelectPage extends StatefulWidget {
  final Product product;
  PaymentSelectPage({Key? key, required this.product}) : super(key: key);

  @override
  State<PaymentSelectPage> createState() => _PaymentSelectPageState();
}

class _PaymentSelectPageState extends State<PaymentSelectPage> {
  late Map<String, List<ProductOption>> optionGroup;
  List<ProductOption>? selectedEventOptions;
  List<ProductOption>? selectedOptions;
  GlobalKey selectOptionKey = GlobalKey();
  DateTime _focusedDay = DateTime.now();

  List<ProductOption> getEventsForDay(DateTime day) {
    if (optionGroup[getDateTime(day, addTimeFormat: false)] != null) {
      return optionGroup[getDateTime(day, addTimeFormat: false)]!;
    } else {
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
    List<ProductOption>? options = widget.product.options;
    if (options != null) {
      options = options.where(canReservation).toList();
      optionGroup = groupBy(options.map((o) => o), (ProductOption option) => getDateTime(option.date, addTimeFormat: false));
      for (var key in optionGroup.keys) {
        List<ProductOption>? list = optionGroup[key];
        bool isExistNotEnd = list!.where((option) {
          bool isNotEnd = getTotalPaymentCount(option) != option.maxParticipants && !option.isReservationEnd;
          return isNotEnd;
        }).isNotEmpty;
        if (!isExistNotEnd) {
          optionGroup[key]?.map((option) {
            option.isReservationEnd = true;
            return option;
          });
        }
      }
    }
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 20),
                  Text('날짜 선택', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  SizedBox(height: 10),
                  NCard(padding: EdgeInsets.fromLTRB(20, 10, 20, 10), child: calendarWidget()),
                  SizedBox(height: 20, key: selectOptionKey),
                  if (selectedEventOptions == null) SizedBox(height: 400),
                  if (selectedEventOptions != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text('수량 선택', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        SizedBox(height: 10),
                        NCard(child: Column(children: selectedEventOptions!.map((option) => productOptionWidget(option)).toList())),
                        SizedBox(height: 200)
                      ],
                    ),
                ],
              ),
            ),
          ],
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

  TableCalendar<ProductOption> calendarWidget() {
    return TableCalendar(
      calendarFormat: CalendarFormat.month,
      calendarBuilders: calendarBuilder(),
      locale: 'ko-KR',
      firstDay: DateTime.utc(2021, 1, 1),
      lastDay: DateTime.utc(2030, 1, 1),
      focusedDay: _focusedDay,
      headerStyle: HeaderStyle(
        headerMargin: EdgeInsets.only(left: 40, right: 40, bottom: 10),
        titleCentered: true,
        formatButtonVisible: false,
      ),
      eventLoader: (day) {
        return getEventsForDay(day);
      },
      calendarStyle: CalendarStyle(
        selectedTextStyle: TextStyle(color: Colors.green),
        todayTextStyle: TextStyle(color: Colors.red),
      ),
      onDaySelected: (selectedDay, focusedDay) {
        if (optionGroup[getDateTime(selectedDay, addTimeFormat: false)] != null) {
          Scrollable.ensureVisible(
            selectOptionKey.currentContext!,
            duration: Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
          List<ProductOption> options = optionGroup[getDateTime(selectedDay, addTimeFormat: false)]!;
          setState(() {
            selectedEventOptions = options.map((option) {
              option.totalPaymentCount = getTotalPaymentCount(option);
              return option;
            }).toList();
            _focusedDay = selectedDay;
          });
        }
      },
    );
  }

  CalendarBuilders<ProductOption> calendarBuilder() {
    return CalendarBuilders(
      todayBuilder: (context, day, focusedDay) {
        return Center(
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 232, 232, 232),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                day.day.toString(),
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      },
      defaultBuilder: (context, day, focusedDay) {
        return Center(
          child: Text(
            day.day.toString(),
            style: TextStyle(color: Colors.grey, fontSize: 18),
          ),
        );
      },
      outsideBuilder: (context, day, focusedDay) {
        return Center(
          child: Text(
            day.day.toString(),
            style: TextStyle(color: Colors.grey, fontSize: 18),
          ),
        );
      },
      markerBuilder: (context, day, events) {
        if (events.isNotEmpty) {
          if (_focusedDay == day) {
            if (events.where((event) => !event.isReservationEnd).isEmpty) {
              return Center(
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(111, 0, 255, 0.12),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          day.day.toString(),
                          style: TextStyle(color: Color.fromRGBO(142, 70, 236, 1), fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Transform.rotate(
                      angle: 45,
                      child: UnconstrainedBox(child: Container(height: 2, width: 25.0, color: Color.fromARGB(255, 79, 79, 79))),
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(111, 0, 255, 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      day.day.toString(),
                      style: TextStyle(color: Color.fromRGBO(142, 70, 236, 1), fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              );
            }
          } else {
            if (events.where((event) => !event.isReservationEnd).isEmpty) {
              return Center(
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Text(
                      day.day.toString(),
                      style: TextStyle(color: Color.fromRGBO(142, 70, 236, 1), fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Transform.rotate(
                      angle: 45,
                      child: UnconstrainedBox(child: Container(height: 2, width: 25.0, color: Color.fromARGB(255, 79, 79, 79))),
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: Text(
                  day.day.toString(),
                  style: TextStyle(color: Color.fromRGBO(142, 70, 236, 1), fontSize: 18, fontWeight: FontWeight.bold),
                ),
              );
            }
          }
        }
        return null;
      },
    );
  }

  Widget productOptionWidget(ProductOption option) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(231, 231, 231, 1)),
        borderRadius: BorderRadius.all(Radius.circular(7)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(option.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: -0.5)),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 5),
                  Text('${NumberFormat().format(option.price)}원', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(height: 5),
                  Text('${option.totalPaymentCount} / ${option.maxParticipants}명 (최소인원: ${option.minParticipants}명)'),
                ],
              ),
              if (!option.isReservationEnd)
                Row(
                  children: [
                    GestureDetector(
                      child: Icon(Icons.remove_circle, size: 28, color: Color.fromRGBO(80, 89, 108, 1)),
                      onTap: () {
                        if (option.count > 0) {
                          setState(() {
                            option.count = option.count - 1;
                          });
                        }
                      },
                    ),
                    SizedBox(width: 13),
                    Text('${option.count}', style: TextStyle(fontSize: 18, color: Color.fromRGBO(80, 89, 108, 1))),
                    SizedBox(width: 13),
                    GestureDetector(
                      child: Icon(Icons.add_circle, size: 28, color: Color.fromRGBO(80, 89, 108, 1)),
                      onTap: () {
                        if (option.count < (option.maxParticipants - option.totalPaymentCount)) {
                          setState(() {
                            option.count = option.count + 1;
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('최대인원은 ${option.maxParticipants - option.totalPaymentCount}명 입니다.'),
                          ));
                        }
                      },
                    ),
                  ],
                ),
              if (option.isReservationEnd) Text('예약 마감', style: TextStyle(color: Colors.grey))
            ],
          ),
          SizedBox(height: 7),
          if (option.description != null && option.description != '') Text(option.description!, style: TextStyle(color: Colors.grey)),
          SizedBox(height: 5),
          Text(getDateTime(option.date)),
        ],
      ),
    );
  }

  bool canReservation(ProductOption option) {
    DateTime date = option.date;
    int reservationHour = widget.product.reservationHours;
    DateTime now = DateTime.now();

    DateTime reservationTime = date.subtract(Duration(hours: reservationHour));
    bool canReservation = now.isBefore(reservationTime);
    return canReservation;
  }

  int getTotalPaymentCount(ProductOption option) {
    if (option.orderItems != null) {
      if (option.orderItems!.isNotEmpty) {
        var counts = option.orderItems!.where((item) => item.order!.payment!.paymentCancel == null).map((item) => item.count);
        return counts.isNotEmpty ? counts.reduce((value, element) => value + element) : 0;
      } else {
        return 0;
      }
    } else {
      return 0;
    }
  }
}
