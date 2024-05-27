import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoesly/riverpod/provider.dart';

enum ContentType { primaryButton, secondaryButton, card, label, icon, listTile }

void onClickEvent(WidgetRef ref, ContentType contentType, String buttonName,
    {Map<String, String>? extraParameter}) async {
  var parameters = {
    "content_type": contentType.toString(),
    "item_id": buttonName,
  };
  parameters.addEntries(extraParameter?.entries ?? {});
  await ref
      .watch(firebaseAnalyticsProvider)
      .logEvent(name: 'on_click', parameters: parameters);
}

void onScreenView(WidgetRef ref, String screenName, String screenClass) {
  ref.watch(firebaseAnalyticsProvider).logEvent(
    name: 'screen_view',
    parameters: {
      'firebase_screen': screenName,
      'firebase_screen_class': screenClass,
    },
  );
}
