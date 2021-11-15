import 'package:flutter/cupertino.dart';

import '../theme.dart';
import 'divider.dart';

class CardWrapper extends StatelessWidget {
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Widget child;

  const CardWrapper({
    Key? key,
    required this.child,
    this.margin = EdgeInsets.zero,
    this.padding = const EdgeInsets.all(12),
  }) : super(key: key);

  factory CardWrapper.divider({
    Key? key,
    required List<Widget> children,
    EdgeInsets margin = EdgeInsets.zero,
    EdgeInsets padding = const EdgeInsets.all(12),
    double? dividerHeight,
    Color dividerColor = CupertinoColors.separator,
    EdgeInsets dividerMargin = EdgeInsets.zero,
  }) {
    final List<Widget> childrenWithDividers = <Widget>[];
    final Divider divider = Divider(
      margin: dividerMargin,
      color: dividerColor,
      height: dividerHeight,
    );

    children.sublist(0, children.length - 1).forEach((child) {
      childrenWithDividers.add(Padding(
        child: child,
        padding: EdgeInsets.only(right: padding.right),
      ));
      childrenWithDividers.add(divider);
    });
    childrenWithDividers.add(Padding(
      child: children.last,
      padding: EdgeInsets.only(right: padding.right),
    ));

    return CardWrapper(
      padding: padding.copyWith(right: 0),
      margin: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: childrenWithDividers,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return Container(
      padding: padding,
      margin: margin,
      child: child,
      decoration: BoxDecoration(
        color: theme.cardBackgroundColor.resolveFrom(context),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
