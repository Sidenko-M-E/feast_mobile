import 'package:feast_mobile_email/events_view_model.dart';
import 'package:feast_mobile_email/features/filters_page/widgets/age_input.dart';
import 'package:feast_mobile_email/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/category_grid.dart';
import 'widgets/date_duration_picker.dart';
import 'widgets/exit_alert_dialog.dart';
import 'widgets/show_events_button.dart';
import 'widgets/time_picker.dart';

class FiltersPage extends StatelessWidget {
  const FiltersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final eventVM = context.watch<EventViewModel>();
    return PopScope(
      canPop: true,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () async {
                if (eventVM.filtersChanged()) {
                  await showExitDialog(
                    context,
                    onSubmit: () {
                      eventVM.applyFiltersChanges();
                      goRouter.pop();
                      goRouter.go('/event_list');
                      eventVM.getEvents();
                    },
                    onCancel: () {
                      goRouter.pop();
                      goRouter.pop();
                    },
                  );
                } else
                  goRouter.pop();
              },
              icon: Icon(Icons.arrow_back)),
          scrolledUnderElevation: 0.0,
          backgroundColor: Colors.white,
          centerTitle: false,
          title: Text(
            'Выберите фильтры',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          actions: [
            Directionality(
              textDirection: TextDirection.rtl,
              child: TextButton.icon(
                onPressed: () {
                  eventVM.resetFilters();
                },
                label: Text(
                  'Сбросить',
                  style: TextStyle(color: Colors.blue),
                ),
                icon: Icon(
                  Icons.replay_rounded,
                  color: Colors.blue,
                ),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Категории', style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: 10),
              eventVM.existingCategories.length > 0
                  ? Flexible(
                      flex: 1,
                      child: CategoryGrid(
                          existingCategories: eventVM.existingCategories,
                          activeCategories: eventVM.filterCategories),
                    )
                    //TODO Обработка ошибки загрузки категорий на панели фильтров
                  : Flexible(
                      flex: 1,
                      child: Container(
                        child: Center(
                          child: Text('Ошибка загрузки категорий'),
                        ),
                      ),
                    ),
              Divider(),
              Flexible(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('Время',
                            style: Theme.of(context).textTheme.labelLarge),
                        Text('от',
                            style: Theme.of(context).textTheme.labelLarge),
                        TimePicker(
                          time: eventVM.startTime,
                          onTap: () async {
                            final TimeOfDay? startTime =
                                await showMyTimePicker(context);
                            if (startTime != null) {
                              eventVM.setFilterStartTime(
                                  'T${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')}:00Z');
                            }
                          },
                        ),
                        Text(
                          'до',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        TimePicker(
                          time: eventVM.endTime,
                          onTap: () async {
                            final TimeOfDay? endTime =
                                await showMyTimePicker(context);
                            if (endTime != null) {
                              eventVM.setFilterEndTime(
                                  'T${endTime.hour.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')}:00Z');
                            }
                          },
                        ),
                      ],
                    ),
                    DateDurationPicker(
                      startDate: eventVM.startDate,
                      endDate: eventVM.endDate,
                      onTap: () async {
                        final DateTimeRange? range =
                            await showMyDateRangePicker(context);
                        if (range != null) {
                          eventVM.setFiltersStartDate(
                              '${range.start.year}-${range.start.month.toString().padLeft(2, '0')}-${range.start.day.toString().padLeft(2, '0')}');
                          eventVM.setFiltersEndDate(
                              '${range.end.year}-${range.end.month.toString().padLeft(2, '0')}-${range.end.day.toString().padLeft(2, '0')}');
                        }
                      },
                    ),
                    AgeInput(
                      controller: eventVM.controller,
                      onChanged: (newValue) => eventVM.setFilterAge(
                          newValue == '' ? 100 : int.parse(newValue)),
                    ),
                  ],
                ),
              ),
              ShowEventsButton(
                onPressed: () {
                  if (eventVM.filtersChanged()) {
                    eventVM.applyFiltersChanges();
                    goRouter.go('/event_list');
                    eventVM.getEvents();
                  } else
                    goRouter.go('/event_list');
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> showExitDialog(BuildContext context,
      {void Function()? onSubmit, void Function()? onCancel}) {
    return showAdaptiveDialog(
        context: context,
        builder: (BuildContext context) => ExitAlertDialog(
              title: 'Вы изменили фильтры',
              description: 'Хотите применить изменения?',
              onSubmit: onSubmit,
              onCancel: onCancel,
            ));
  }
}

Future<DateTimeRange?> showMyDateRangePicker(BuildContext context) {
  return showDateRangePicker(
    context: context,
    locale: const Locale('ru'),
    firstDate: DateTime(2025),
    lastDate: DateTime(2026),
  );
}

Future<TimeOfDay?> showMyTimePicker(BuildContext context) {
  return showTimePicker(
    context: context,
    helpText: 'Выберите время',
    cancelText: 'Отмена',
    errorInvalidText: 'Введите корректное время',
    confirmText: 'ОК',
    hourLabelText: 'Часы',
    minuteLabelText: 'Минуты',
    initialTime: TimeOfDay(hour: 0, minute: 0),
    initialEntryMode: TimePickerEntryMode.dial,
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: Theme.of(context).copyWith(
          materialTapTargetSize: MaterialTapTargetSize.padded,
        ),
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child!,
          ),
        ),
      );
    },
  );
}
