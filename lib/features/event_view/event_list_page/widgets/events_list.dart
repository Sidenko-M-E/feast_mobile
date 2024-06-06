import 'package:feast_mobile_email/features/event_view/event_list_page/widgets/event_card.dart';
import 'package:feast_mobile_email/view_models/events_view_model.dart';
import 'package:feast_mobile_email/models/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EventsList extends StatelessWidget {
  const EventsList({super.key});

  @override
  Widget build(BuildContext context) {
    final eventVM = context.watch<EventViewModel>();
    final eventListLength = eventVM.eventList.length;
    return eventVM.loading == true
        ? (Flexible(child: Center(child: CircularProgressIndicator(color: Colors.blue,))))
        : (eventVM.eventList.length > 0
            ? Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(10),
                  itemCount: eventListLength,
                  itemBuilder: (context, index) {
                    final Event event = eventVM.eventList[index];
                    return Column(
                      children: [
                        EventCard(
                          event: event,
                          onTap: () async {
                            eventVM.setSelectedEvent(event);
                            context.push('/event_details');
                          },
                        ),
                        Divider(color: Colors.white)
                      ],
                    );
                  },
                ),
              )
            : Flexible(child: Center(child: Text('Мероприятий нет.'))));
  }
}
