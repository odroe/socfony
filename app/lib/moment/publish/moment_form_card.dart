import 'package:flutter/material.dart';

import 'add_moment_image_button.dart';
import 'moment_content_text_field.dart';
import 'moment_title_text_field.dart';

class MomentFormCard extends StatelessWidget {
  const MomentFormCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: ListBody(
        children: const <Widget>[
          MomentTitleTextField(),
          Divider(height: 0),
          MomentContextTextField(),
          AddMomentImageButton(),
          SizedBox(height: 24),
        ],
      ),
    );
  }
}
