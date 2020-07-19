import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutils/flutils.dart';

PasswordEditingController usePasswordEditingController({
  String text,
  bool showText,
}) {
  return use(
    _PasswordEditingControllerHook(text: text, showText: showText),
  );
}

class _PasswordEditingControllerHook extends Hook<PasswordEditingController> {
  const _PasswordEditingControllerHook({this.text, this.showText});

  final String text;
  final bool showText;

  @override
  _PasswordEditingControllerHookState createState() =>
      _PasswordEditingControllerHookState();
}

class _PasswordEditingControllerHookState<T> extends HookState<
    PasswordEditingController, _PasswordEditingControllerHook> {
  PasswordEditingController controller;

  @override
  void initHook() {
    super.initHook();
    controller = PasswordEditingController(
      text: hook.text,
      showText: hook.showText,
    )..addListener(_listener);
  }

  @override
  void dispose() {
    controller.removeListener(_listener);
    controller.dispose();
  }

  @override
  PasswordEditingController build(BuildContext context) {
    return controller;
  }

  void _listener() {
    setState(() {});
  }
}
