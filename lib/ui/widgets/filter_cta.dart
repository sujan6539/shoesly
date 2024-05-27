import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shoesly/analytics/analytics_helper.dart';
import 'package:shoesly/model/filter.dart';
import 'package:shoesly/riverpod/provider.dart';
import 'package:shoesly/ui/widgets/primary_button.dart';
import 'package:shoesly/ui/widgets/secondary_button.dart';

class FilterCTA extends ConsumerWidget {
  Filter filter;
  FilterCTA(this.filter, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var filterState = ref.watch(filterStateNotifier.notifier);
    return SizedBox(
      height: 80,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SecondaryButton(
                onPressed: () {
                  onClickEvent(ref, ContentType.secondaryButton, 'Reset');
                },
                title: 'Reset'),
            PrimaryButton(
              onPressed: () {
                filterState.updateState(newFilter: filter);
                onClickEvent(ref, ContentType.primaryButton, 'Apply');
                context.push('/filter');
              },
              title: 'Apply',
            )
          ],
        ),
      ),
    );
  }
}
