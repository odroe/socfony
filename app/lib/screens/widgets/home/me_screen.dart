import 'package:flutter/material.dart';

class HomeMeScrren extends StatefulWidget {
  const HomeMeScrren({ Key? key }) : super(key: key);

  @override
  _HomeMeScrrenState createState() => _HomeMeScrrenState();
}

class _HomeMeScrrenState extends State<HomeMeScrren> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Seven的代码太渣'),
        actions: [
          IconButton(
            tooltip: '设置',
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: const <Widget>[
          _UserCard(),
          Divider(
            thickness: 10,
            height: 36,
          ),
        ],
      ),
    );
  }
}

class _UserCard extends StatelessWidget {
  const _UserCard({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(child: Text('我尽量在无人留言的地方留言。  我们都是别人的风景，别人都是我们的故事', style: Theme.of(context).textTheme.caption,),),
              const SizedBox(width: 20),
              const CircleAvatar(
                radius: 36,
              ),
            ],
          ),
          Row(
            children: [
              Column(
                children: [
                  Text('387', style: Theme.of(context).textTheme.headline6,),
                  Text('关注', style: Theme.of(context).textTheme.caption,),
                ],
              ),
              const SizedBox(width: 20),
              Column(
                children: [
                  Text('387', style: Theme.of(context).textTheme.headline6,),
                  Text('粉丝', style: Theme.of(context).textTheme.caption,),
                ],
              ),
              const SizedBox(width: 20),
              Column(
                children: [
                  Text('387', style: Theme.of(context).textTheme.headline6,),
                  Text('动态', style: Theme.of(context).textTheme.caption,),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
