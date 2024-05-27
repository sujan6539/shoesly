import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoesly/analytics/analytics_helper.dart';

PreferredSizeWidget getAppBarWidget(
    WidgetRef ref, BuildContext context, String title, List<Widget> actions) {
  return AppBar(
    centerTitle: true,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        onClickEvent(ref, ContentType.icon, "arrow back",
            extraParameter: {'item_parent': 'appBar'});
        Navigator.pop(context);
      },
    ),
    title: Text(
      title,
      style:
          const TextStyle(fontSize: 18).copyWith(fontWeight: FontWeight.w600),
      textAlign: TextAlign.center,
    ),
    actions: actions,
  );
}
