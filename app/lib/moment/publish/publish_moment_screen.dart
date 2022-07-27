import 'package:flutter/material.dart';

import 'moment_form_card.dart';
import 'moment_publish_button.dart';
import 'publish_screen_will_pop.dart';

/// Publish moment screen.
class PublishMomentScreen extends StatelessWidget {
  const PublishMomentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PublishScreenWillPop(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('发布动态'),
          actions: const <Widget>[MomentPublishButton()],
        ),
        body: ListView(
          children: const <Widget>[
            SizedBox(height: 24),
            MomentFormCard(),
          ],
        ),
      ),
    );
  }
}
