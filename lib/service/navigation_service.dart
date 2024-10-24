import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationService {
  late GlobalKey<NavigatorState> navigatorKey;

  NavigationService() {
    navigatorKey = GlobalKey<NavigatorState>();
  }

  navigate(Widget widget) {
    return navigatorKey.currentState?.push(CupertinoPageRoute(
      builder: (context) => widget,
    ));
  }

  Future<void> showDialog(BuildContext? context, Widget widget) async {
    await showAdaptiveDialog(
      context: context ?? navigatorKey.currentContext!,
      builder: (context) => widget,
    );
  }

  void showSnackbar() {
    final context = navigatorKey.currentContext!;
    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
    final snackbarWidget = SnackBar(content: const Text("Hello"));
    ScaffoldMessenger.of(context).showSnackBar(snackbarWidget);
  }
}
