import 'package:flutter/material.dart';

class NoteWidget extends StatelessWidget {
  const NoteWidget({required Key key, required this.note}) : super(key: key);

  final String note;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - 100,
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(note),
            ],
          ),
        ],
      ),
    );
  }
}
