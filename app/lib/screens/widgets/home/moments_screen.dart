import 'package:flutter/material.dart';

class HomeMomentsScreen extends StatefulWidget {
  const HomeMomentsScreen({Key? key}) : super(key: key);

  @override
  State<HomeMomentsScreen> createState() => _HomeMomentsScreenState();
}

class _HomeMomentsScreenState extends State<HomeMomentsScreen>
    with
        AutomaticKeepAliveClientMixin<HomeMomentsScreen>,
        SingleTickerProviderStateMixin<HomeMomentsScreen> {
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
