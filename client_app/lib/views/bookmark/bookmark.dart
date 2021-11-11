import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../components/components.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({Key? key}) : super(key: key);

  @override
  _BookmarkScreenState createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  List<String> pillList = [];

  @override
  void initState() {
    super.initState();
    _getPillList().then((value) {
      setState(() {
        pillList = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("북마크", style: CTypography.appbarTitle.style),
          backgroundColor: CColor.primary.color,
        ),
        body: AnimationLimiter(
            child: ListView.separated(
          padding: const EdgeInsets.all(32),
          itemCount: pillList.length,
          itemBuilder: (BuildContext context, int index) {
            return SizedBox(
                height: 50,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        (index + 1).toString() + '.  ' + pillList[index],
                        style: CTypography.title.style,
                      ),
                    ]));
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(
            thickness: 3,
          ),
        )));
  }

  Future<List<String>> _getPillList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getKeys().toList();
  }
}
