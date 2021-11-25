import 'package:flutter/material.dart';

class MainMomentsScreen extends StatefulWidget {
  const MainMomentsScreen({Key? key}) : super(key: key);

  @override
  State<MainMomentsScreen> createState() => _MainMomentsScreenState();
}

class _MainMomentsScreenState extends State<MainMomentsScreen>
    with
        AutomaticKeepAliveClientMixin<MainMomentsScreen>,
        SingleTickerProviderStateMixin<MainMomentsScreen> {
  late final TabController tabController;

  @override
  void initState() {
    super.initState();

    tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        title: TabBar(
          isScrollable: true,
          controller: tabController,
          tabs: const <Widget>[
            Tab(text: '推荐'),
            Tab(text: '关注'),
          ],
        ),
        centerTitle: false,
      ),
      body: const Center(
        child: Text(
          'Moments',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
