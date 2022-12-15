import 'package:flutter/material.dart';
import 'package:pubdev_playground/common/translate.dart';
import 'package:pubdev_playground/ui/pages/setting/setting.logic.dart';
import 'package:pubdev_playground/ui/pages/tab_1/tab_1.logic.dart';

class TabView1Page extends StatelessWidget {
  final Tab1Page page;

  const TabView1Page({
    Key? key,
    required this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text(tt.tab_page.tab_title_first),
              ),
              Tab(
                child: Text(tt.tab_page.tab_title_second),
              ),
              Tab(
                child: Text(tt.tab_page.tab_title_setting),
              ),
            ],
          ),
          title: Text(tt.tab_page.title),
        ),
        body: TabBarView(
          children: [
            const Text('Tab1'),
            const Text('Tab2'),
            SettingPage.build(
              onlyContent: true,
            ),
          ],
        ),
      ),
    );
  }
}
