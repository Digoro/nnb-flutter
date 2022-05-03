import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

import '../models/product.dart';
import 'home_page.dart';

class ProductDetailAppBar extends StatefulWidget {
  Color textColor = Colors.white;
  Product product;
  ScrollController scrollController;

  ProductDetailAppBar({Key? key, required this.product, required this.scrollController}) : super(key: key);

  @override
  State<ProductDetailAppBar> createState() => _ProductDetailAppBarState();
}

class _ProductDetailAppBarState extends State<ProductDetailAppBar> {
  @override
  void initState() {
    super.initState();

    widget.scrollController.addListener(() {
      setState(() {
        widget.textColor = _isSliverAppBarExpanded ? Colors.black : Colors.white;
      });
    });
  }

  bool get _isSliverAppBarExpanded {
    return widget.scrollController.hasClients && widget.scrollController.offset > (320 - kToolbarHeight);
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      snap: false,
      floating: false,
      expandedHeight: 320.0,
      toolbarHeight: 60,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: widget.textColor),
      elevation: 1,
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
            Clipboard.setData(ClipboardData(text: 'https://nonunbub.com/tabs/meeting-detail/${widget.product.id}'));
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
          children: widget.product.representationPhotos.map((e) => Image.network(e.photo, fit: BoxFit.cover)).toList(),
          isLoop: false,
        ),
      ),
    );
  }
}
