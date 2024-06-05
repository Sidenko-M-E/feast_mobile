import 'package:feast_mobile_email/features/event_list_page/widgets/search_panel.dart';
import 'package:flutter/material.dart';

import 'widgets/events_list.dart';

class EventListPage extends StatelessWidget {
  const EventListPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(0, 0),
        child: AppBar(backgroundColor: Colors.blue),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SearchPanel(),
            EventsList(),
          ],
        ),
      ),
    );
  }
}
