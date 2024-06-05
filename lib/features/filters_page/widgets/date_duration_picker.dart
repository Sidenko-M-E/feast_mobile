import 'package:flutter/material.dart';

class DateDurationPicker extends StatelessWidget {
  const DateDurationPicker({
    super.key,
    this.onTap,
    required this.startDate,
    required this.endDate,
  });

  final String startDate;
  final String endDate;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 2, color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Icon(Icons.calendar_month_outlined),
                SizedBox(width: 10),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Даты', style: Theme.of(context).textTheme.labelLarge),
                  Text('$startDate — $endDate',
                      style: Theme.of(context).textTheme.labelMedium),
                ]),
                Spacer(),
                Icon(Icons.arrow_drop_down)
              ],
            ),
          )),
    );
  }
}
