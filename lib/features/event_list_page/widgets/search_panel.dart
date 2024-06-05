import 'package:feast_mobile_email/events_view_model.dart';
import 'package:feast_mobile_email/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPanel extends StatelessWidget {
  const SearchPanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final eventViewModel = context.watch<EventViewModel>();
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey,
          blurStyle: BlurStyle.outer,
          blurRadius: 20,
          offset: Offset(0, 0),
          spreadRadius: 0.5,
        )
      ], color: Colors.blue),
      height: 120,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (value){
                //TODO Добавить сортировку по названию 
              },
              maxLength: 50,
              decoration: InputDecoration(
                counterStyle: TextStyle(fontSize: 0),
                errorStyle: TextStyle(fontSize: 0),
                hintText: 'Найти мероприятие',
                prefixIcon: Icon(Icons.search),
                suffixIcon: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          left: BorderSide(color: Colors.grey, width: 2))),
                  child: IconButton(
                    icon: Icon(Icons.tune),
                    onPressed: () {
                      eventViewModel.createFiltersDup();
                      goRouter.push('/event_filters');
                    },
                  ),
                ),
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.grey)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Colors.grey)),
              ),
            ),
            SizedBox(height: 5),
            Text('Найдено мероприятий: ${eventViewModel.eventList.length}',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                )),
          ],
        ),
      ),
    );
  }
}