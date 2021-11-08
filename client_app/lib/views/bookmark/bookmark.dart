import 'package:flutter/material.dart';

import '../../../components/components.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({Key? key}) : super(key: key);

  @override
  _BookmarkScreenState createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("북마크", style: CTypography.appbarTitle.style),
          backgroundColor: CColor.primary.color,
        ),
        body: Center(
          child: Text("hi")
        ));
  }
}
