import 'package:flutter/material.dart';

import './text_search_picker.dart';
import '../../components/components.dart';

class TextSearchScreen extends StatefulWidget {
  const TextSearchScreen({Key? key}) : super(key: key);

  @override
  _TextSearchScreenState createState() => _TextSearchScreenState();
}

class _TextSearchScreenState extends State<TextSearchScreen> {
  late final ScrollController scrollController;
  final GlobalKey _formKey = GlobalKey();

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
              title: const Text('Text Search'),
              expandedHeight: 30,
              collapsedHeight: 80,
            ),
            SliverList(
                delegate: SliverChildListDelegate(
              <Widget>[
                TextFormField(
                  decoration: roundedInputDecoration(
                    labelText: '약품명',
                    icon: const Icon(Icons.text_format_rounded),
                  ),
                ),
                TextButton(
                    onPressed: () => showModalBottomSheet(
                          backgroundColor: const Color(0x00000000),
                          context: context,
                          builder: textColorPicker,
                        ),
                    child: const Text('Select Color'))
              ],
            ))
          ],
        ),
      ),
    );
  }
}
