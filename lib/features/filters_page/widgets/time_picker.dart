import 'package:flutter/material.dart';

class TimePicker extends StatelessWidget {
  const TimePicker({
    super.key,
    this.time,
    // required this.text,
    this.onTap,
  });

  final String? time;
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
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${time}',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                SizedBox(width: 40),
                Icon(Icons.arrow_drop_down)
              ],
            ),
          )),
    );
  }
}
