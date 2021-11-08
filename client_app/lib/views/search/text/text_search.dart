import 'package:client_app/views/result/top_result.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import './text_search_picker.dart';
import './text_search_controller.dart';
import '../../../components/components.dart';

class TextSearchScreen extends StatefulWidget {
  const TextSearchScreen({Key? key}) : super(key: key);

  @override
  _TextSearchScreenState createState() => _TextSearchScreenState();
}

class _TextSearchScreenState extends State<TextSearchScreen> {
  final GlobalKey _formKey = GlobalKey();

  /// controller
  late final ScrollController scrollController;

  /// variables selected by user

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: CustomScrollView(
          shrinkWrap: true,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          controller: scrollController,
          slivers: [
            SliverAppBar(
              backgroundColor: CColor.primary.color,
              title: Text('Text Search', style: CTypography.appbarTitle.style),
            ),
            SliverPadding(
              padding: padding(horizontal: 8.0, vertical: 16.0),
              sliver: SliverList(
                  delegate: SliverChildListDelegate(
                <Widget>[
                  TextFormField(
                    decoration: roundedInputDecoration(
                      labelText: '약품명',
                      icon: const Icon(Icons.text_format_rounded),
                    ),
                  ),
                  GetBuilder<TextSearchController>(
                      init: TextSearchController(),
                      builder: (selected) => Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () =>
                                        showTextSearchPicker(type: 'color'),
                                    child: const Text('색상 선택'),
                                  ),
                                  Text('${selected.color}')
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () =>
                                        showTextSearchPicker(type: 'shape'),
                                    child: const Text('모양 선택'),
                                  ),
                                  Text('${selected.shape}')
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () =>
                                        showTextSearchPicker(type: 'character'),
                                    child: const Text('제형 선택'),
                                  ),
                                  Text('${selected.character}')
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () =>
                                        showTextSearchPicker(type: 'divider'),
                                    child: const Text('구분선 선택'),
                                  ),
                                  Text('${selected.divider}')
                                ],
                              ),
                            ],
                          )),
                  TextButton(
                    onPressed: () => Get.to(() => TopResultScreen()),
                    child: const Text('검색하기'),
                  ),
                ],
              )),
            )
          ],
        ),
      ),
    );
  }
}
