import 'package:flutter/cupertino.dart';

import '../theme.dart';

class Divider extends StatelessWidget {
  final double? height;
  final Color? color;
  final EdgeInsets? margin;
  final WidgetBuilder? builder;

  const Divider({
    Key? key,
    Color color = CupertinoColors.separator,
    EdgeInsets margin = EdgeInsets.zero,
    double? height,
  }) : this._raw(
          key: key,
          color: color,
          margin: margin,
          height: height,
          builder: null,
        );

  const Divider._raw({
    Key? key,
    this.height,
    this.color,
    this.margin,
    this.builder,
  }) : super(key: key);

  factory Divider.central({
    Color color = CupertinoColors.separator,
    EdgeInsets margin = EdgeInsets.zero,
    double? height,
    Widget? child,
    WidgetBuilder? builder,
  }) {
    assert(child == null || builder == null);

    final divider = Expanded(
      child: Divider._raw(
        color: color,
        height: height,
      ),
    );

    return Divider._raw(
      builder: (BuildContext context) {
        return Padding(
          padding: margin,
          child: Row(
            children: [
              divider,
              child is Widget ? child : builder!(context),
              divider,
            ],
          ),
        );
      },
    );
  }

  factory Divider.title({
    Color color = CupertinoColors.separator,
    EdgeInsets margin = EdgeInsets.zero,
    double? height,
    TextStyle? style,
    required String title,
  }) {
    return Divider.central(
      color: color,
      margin: margin,
      height: height,
      builder: (BuildContext context) => Text(
        title,
        style: style ??
            AppTheme.of(context).textTheme.footnote.copyWith(
                  color: CupertinoDynamicColor.maybeResolve(color, context),
                ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (builder != null) {
      return builder!(context);
    }

    return Container(
      margin: margin,
      color: CupertinoDynamicColor.maybeResolve(color, context),
      height: height ?? 1.0 / MediaQuery.of(context).devicePixelRatio,
    );
  }
}
