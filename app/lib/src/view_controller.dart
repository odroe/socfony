import 'package:flutter/widgets.dart';

abstract class Controller {
  late BuildContext _context;

  BuildContext get context => _context;
}

class ViewElement<T extends Controller> extends StatelessElement {
  ViewElement(View<T> widget) : super(widget) {
    widget.controller._context = this;
  }
}

abstract class View<T extends Controller> extends StatelessWidget {
  const View({Key? key}) : super(key: key);

  @protected
  T get controller;

  @override
  StatelessElement createElement() => ViewElement<T>(this);
}
