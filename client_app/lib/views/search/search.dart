import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './text/text_search.dart';
import '../result/top_result.dart';
import '../../components/components.dart';

class SearchMainScreen extends StatelessWidget {
  SearchMainScreen({Key? key}) : super(key: key);

  final searchItems = ['Text', 'Camera', 'QR'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search', style: CTypography.appbarTitle.style),

        /// you can use sort of colors defined in `CColor` - @seunghwanly
        backgroundColor: CColor.primary.color,
      ),
      body: SafeArea(
        child: Center(
          child: ListView.separated(
              itemBuilder: (context, index) => ListTile(
                    onTap: () => Get.to(() => TopResultScreen()),
                    title: Text(searchItems[index]),
                  ),
              separatorBuilder: (context, index) => blankBox(height: 10),
              itemCount: 3),
        ),
      ),
    );
  }
}
