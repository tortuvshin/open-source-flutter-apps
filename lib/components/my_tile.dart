import 'package:flutter/material.dart';

class MyWeatherTile extends StatelessWidget {
  
  final String imgPath;
  final String title;
  final String value;
  
  const MyWeatherTile({
    super.key,
    required this.imgPath,
    required this.title,
    required this.value
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          imgPath,
          scale: 8,
        ),
        const SizedBox(width: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
            ),
            const SizedBox(height: 3),
            Text(
              value,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w700),
            ),
          ],
        )
      ],
    );
  }
}
