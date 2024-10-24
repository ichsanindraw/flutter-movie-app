import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_app/constants/app_colors.dart';

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

  navigateReplace(Widget widget) {
    return navigatorKey.currentState?.pushReplacement(CupertinoPageRoute(
      builder: (context) => widget,
    ));
  }

  Future<void> showDialog(BuildContext? context, Widget widget) async {
    await showAdaptiveDialog(
      context: context ?? navigatorKey.currentContext!,
      builder: (context) => widget,
    );
  }

  void showSnackbar(String message) {
    final context = navigatorKey.currentContext!;
    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();

    final snackbarWidget = SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(
        message,
        style: TextStyle(
          color: AppColors.whiteColor,
        ),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbarWidget);
  }
}
