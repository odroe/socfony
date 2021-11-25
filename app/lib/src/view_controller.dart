import 'package:flutter/widgets.dart';

abstract class ViewController {
  @protected
  late BuildContext _context;

  @protected
  BuildContext get context => _context;
}

class ViewElement<T extends ViewController> extends StatelessElement {
  ViewElement(ViewWidget<T> widget) : super(widget) {
    widget.controller._context = this;
  }
}

abstract class ViewWidget<T extends ViewController> extends StatelessWidget {
  const ViewWidget({Key? key}) : super(key: key);

  @protected
  T get controller;

  @override
  StatelessElement createElement() => ViewElement<T>(this);
}
