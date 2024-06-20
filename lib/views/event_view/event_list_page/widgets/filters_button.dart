import 'package:flutter/material.dart';

class FiltersButton extends StatelessWidget {
  const FiltersButton({
    super.key,
    this.onTap,
  });

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Фильтры'),
                SizedBox(width: 10),
                Icon(Icons.tune),
              ],
            )),
      ),
    );
  }
}

// PreferredSize(
//           preferredSize: Size(0, 0),
//           child:
//               //AppBar(backgroundColor: Colors.blue),
//               AppBar(
//             backgroundColor: Colors.blue,
//             actions: [

//             ],
//           )),
