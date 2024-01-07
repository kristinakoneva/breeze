import 'package:breeze/config/theme/colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: SafeArea(
            child: Column(
              children: [
                Flex(
                  direction: Axis.horizontal,
                  children: [
                    Expanded(
                      child: SearchBar(
                        constraints: const BoxConstraints(
                          minHeight: 30,
                        ),
                        shape: MaterialStateProperty.all(
                            const ContinuousRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        )),
                        leading: const Icon(
                          Icons.search,
                          color: colorSurface,
                        ),
                        hintText: 'Search',
                        onSubmitted: (String value) {
                          // TODO: Implement search
                        },
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // TODO: Implement settings
                      },
                      icon: const Icon(Icons.settings),
                    )
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
