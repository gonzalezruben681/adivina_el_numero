import 'package:flutter/material.dart';

class CustomListView extends StatelessWidget {
  final int? itemCount;
  final List<int> items;
  final String? title;
  const CustomListView(
      {super.key, this.itemCount, required this.items, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 200,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black54),
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Text(
              title ?? '',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 5),
          Expanded(
            child: ListView.builder(
              itemCount: itemCount,
              itemBuilder: (BuildContext context, int index) {
                return Center(
                    child: Text(
                  '${items[index]}',
                  style: const TextStyle(fontSize: 16),
                ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
