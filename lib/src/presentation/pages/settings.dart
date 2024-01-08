import 'package:breeze/config/theme/colors.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          iconSize: 32,
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.chevron_left),
        ),
        title: const Text("SETTINGS"),
      ),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: SafeArea(
        child: Column(children: [
          Flex(
            direction: Axis.horizontal,
            children: [
              const Expanded(
                child: Text(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  "Imperial unit system",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Switch(
                value: false,
                overlayColor:
                    const MaterialStatePropertyAll<Color>(Colors.grey),
                trackColor: const MaterialStatePropertyAll<Color>(Colors.white),
                thumbColor: const MaterialStatePropertyAll<Color>(colorPrimary),
                onChanged: (value) {
                  // TODO: Implement logic for changing unit system
                },
              ),
            ],
          ),
          const Text(
            softWrap: true,
            "When this setting is switched off, the default unit system is the metric unit system.",
            style: TextStyle(fontSize: 12),
          ),
          const SizedBox(
            height: 16,
          ),
          Flex(
            direction: Axis.horizontal,
            children: [
              const Expanded(
                child: Text(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  "Delete search history",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              IconButton(
                iconSize: 30,
                onPressed: () {
                  // TODO: Implement logic for deleting search history
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
