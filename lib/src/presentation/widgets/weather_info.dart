import 'package:breeze/config/theme/colors.dart';
import 'package:flutter/material.dart';

/// Widget to display weather information.
class WeatherInfoWidget extends StatelessWidget {
  final String label;
  final String value;

  const WeatherInfoWidget({Key? key, required this.label, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        color: Colors.white,
      ),
      child: Flex(
        direction: Axis.vertical,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.topCenter,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              color: colorPrimary,
            ),
            child: Text(
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              label,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            child: Text(
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              value,
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
