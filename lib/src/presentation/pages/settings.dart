import 'package:breeze/config/theme/colors.dart';
import 'package:breeze/core/constants/constants.dart';
import 'package:breeze/src/data/local/shared_preferences.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  final String unitSystem;

  const SettingsPage({Key? key, required this.unitSystem}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool? isImperialUnitSystem;

  onWillPop() {
    Navigator.pop(context, isImperialUnitSystem);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          Navigator.pop(context, isImperialUnitSystem);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            iconSize: 32,
            onPressed: () => Navigator.pop(context, isImperialUnitSystem),
            icon: const Icon(Icons.chevron_left),
          ),
          title: const Text("SETTINGS"),
        ),
        body: _buildBody(),
      ),
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
                value: isImperialUnitSystem ??
                    (widget.unitSystem == imperialUnitSystem),
                overlayColor:
                    const MaterialStatePropertyAll<Color>(Colors.grey),
                trackColor: const MaterialStatePropertyAll<Color>(Colors.white),
                thumbColor: const MaterialStatePropertyAll<Color>(colorPrimary),
                onChanged: (isImperialUnitSystem) {
                  final unitSystem = isImperialUnitSystem
                      ? imperialUnitSystem
                      : metricUnitSystem;
                  setUnitSystem(unitSystem);
                  setState(() {
                    this.isImperialUnitSystem = isImperialUnitSystem;
                  });
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
                  _showDeleteHistoryConfirmationDialog();
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
        ]),
      ),
    );
  }

  /// Shows a confirmation dialog for deleting search history.
  _showDeleteHistoryConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: const Text(
            "Are you sure you want to delete your search history?",
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: colorPrimary,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("CANCEL",
                  style: TextStyle(color: Colors.white, fontSize: 12)),
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: colorPrimary,
              ),
              onPressed: () {
                clearSearchSuggestions();
                Navigator.pop(context);
                _showSnackBar("Search history deleted");
              },
              child: const Text("DELETE",
                  style: TextStyle(color: Colors.white, fontSize: 12)),
            ),
          ],
        );
      },
    );
  }

  /// Shows a [SnackBar] with the provided message.
  _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
