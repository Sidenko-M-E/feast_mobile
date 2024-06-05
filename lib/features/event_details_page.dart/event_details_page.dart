import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:feast_mobile_email/events_view_model.dart';
import 'package:feast_mobile_email/models/category.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EventDetailsPage extends StatelessWidget {
  const EventDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedEvent = context.watch<EventViewModel>().selectedEvent;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
        backgroundColor: Colors.white,
        title: Text('О мероприятии'),
        titleTextStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${selectedEvent.name}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            if (selectedEvent.description != '') SizedBox(height: 10),
            if (selectedEvent.description != '')
              RichText(
                maxLines: 4,
                text: TextSpan(text: '', children: [
                  TextSpan(
                    text: '${selectedEvent.description}',
                    style: TextStyle(color: Colors.black),
                    recognizer: TapGestureRecognizer()..onTap = () {},
                  )
                ]),
              ),
            Column(
              children: [
                SizedBox(height: 20),
                Row(
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      color: Colors.grey[700],
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Время:'),
                        Text(
                            '${selectedEvent.startTime.substring(11, 16)} — ${selectedEvent.endTime.substring(11, 16)}')
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.place, color: Colors.grey[700]),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Адрес:'),
                        Text('${selectedEvent.place.address}')
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.tune, color: Colors.grey[700]),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Категории:'),
                        Text(
                            '${selectedEvent.categories.map((CategoryModel e) => e.name.toString()).toList().join(' | ')}')
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.align_horizontal_left_sharp,
                        color: Colors.grey[700]),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Возрастное ограничение:'),
                        Text(
                          '${selectedEvent.ageLimit}+',
                        )
                      ],
                    ),
                  ],
                ),
              ],
            ),
            if (selectedEvent.imageUrls.length != 0) SizedBox(height: 20),
            if (selectedEvent.imageUrls.length != 0)
              Text(
                'Фотографии',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            Expanded(
              child: GridView.extent(
                  maxCrossAxisExtent: 150,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  children: selectedEvent.imageUrls
                      .map((e) => GestureDetector(
                            onTap: () {
                              showImageViewer(
                                backgroundColor: Colors.white,
                                closeButtonColor: Colors.black,
                                context,
                                Image.network(e, fit: BoxFit.scaleDown).image,
                                swipeDismissible: false,
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Image.network(e, fit: BoxFit.scaleDown),
                            ),
                          ))
                      .toList()),
            ),
            ElevatedButton.icon(
              icon: Icon(
                Icons.check,
                size: 20,
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                textStyle:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: () {
                // TODO Сделать навигацию на построение маршрута
              },
              label: Text('Пойду'),
            )
          ],
        ),
      ),
    );
  }
}
