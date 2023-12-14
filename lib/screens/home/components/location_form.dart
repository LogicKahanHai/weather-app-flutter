import 'package:flutter/material.dart';

class LocationForm extends StatefulWidget {
  final void Function(String) onSubmitted;
  const LocationForm({super.key, required this.onSubmitted});

  @override
  State<LocationForm> createState() => _LocationFormState();
}

class _LocationFormState extends State<LocationForm> {
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: Column(
        children: [
          TextField(
            controller: textController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter a city',
            ),
            onSubmitted: (value) {},
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              foregroundColor: Theme.of(context).colorScheme.onSecondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              minimumSize: const Size(200, 40),
            ),
            onPressed: () {
              widget.onSubmitted(textController.text);
              textController.clear();
            },
            child: const Text('Search'),
          ),
        ],
      ),
    );
  }
}
