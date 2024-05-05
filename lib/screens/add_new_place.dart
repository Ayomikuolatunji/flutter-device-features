import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:net_ninja_course/models/place.dart';
import 'package:net_ninja_course/providers/user_places.dart';
import 'package:net_ninja_course/widgets/image_input.dart';
import 'package:net_ninja_course/widgets/location_input.dart';

class AddNewPlace extends ConsumerStatefulWidget {
  const AddNewPlace({super.key});

  @override
  ConsumerState<AddNewPlace> createState() => _AddNewPlaceState();
}

class _AddNewPlaceState extends ConsumerState<AddNewPlace> {
  final _titleController = TextEditingController();
  File? _selectedImage;

  void savePlace() {
    final enteredText = _titleController.text;
    if (enteredText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please provide the place title")));
    }
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please select image to continue")));
    }
    ref
        .read(userPlacesNotifier.notifier)
        .addNewPlace(Place(title: enteredText, image: _selectedImage!));

    Navigator.of(context).pop();
  }

  void onSelectedImage(File selectedImage) {
    setState(() {
      _selectedImage = selectedImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new place"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(label: Text("Title")),
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onBackground),
              controller: _titleController,
            ),
            const SizedBox(
              height: 10,
            ),
            ImageInput(
              selectedImage: onSelectedImage,
            ),
            const SizedBox(
              height: 10,
            ),
            const LocationInput(),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton.icon(
                onPressed: () {
                  savePlace();
                },
                icon: const Icon(Icons.add),
                label: const Text("Add new place"))
          ],
        ),
      ),
    );
  }
}
