import 'package:flutter/material.dart';

class ForeCastCard extends StatelessWidget {
  final String forecastTime;
  final String tempC;
  final String condition;
  final String icon;
  const ForeCastCard({
    super.key,
    required this.forecastTime,
    required this.tempC,
    required this.condition,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(forecastTime, style: const TextStyle(fontWeight: FontWeight.bold),),
          Text('$tempC°C'),
          SizedBox(
            width: 100,
            child: Text(condition, 
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: const TextStyle(fontWeight: FontWeight.bold)
            ),
          ),
          Image.network(
            'http:$icon',
          ),
        ],
      ),
    );
  }
}
