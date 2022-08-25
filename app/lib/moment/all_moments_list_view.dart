import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:socfonyapis/socfonyapis.dart';

import '../socfony_service.dart';
import 'moment_list_card.dart';
import 'moment_providers.dart';

final _all = StateProvider.autoDispose((ref) => <String>[]);

class AllMomentsListView extends ConsumerWidget {
  const AllMomentsListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch all moments count.
    final int count = ref.watch(
      _all.select((List<String> moments) => moments.length),
    );

    return RefreshIndicator(
      onRefresh: () => onRefresh(ref.read),
      child: ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int index) =>
            itemBuilder(ref, context, index),
      ),
    );
  }

  /// List item builder.
  Widget itemBuilder(WidgetRef ref, BuildContext context, int index) {
    final String id = ref.watch(
      _all.select((List<String> moments) => moments[index]),
    );

    return MomentListCard(id: id);
  }

  /// Refresh the moments list.
  Future<void> onRefresh(Reader reader) async {
    final Pagination request = Pagination()
      ..take = 15
      ..skip = 0;

    final MomentList list = await socfonyService.allMoments(request);
    for (final Moment moment in list.moments) {
      moment.save(reader);
    }

    reader(_all.state).state = list.moments.map((moment) => moment.id).toList();
  }
}
