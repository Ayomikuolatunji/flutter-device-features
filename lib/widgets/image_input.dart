import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.selectedImage});

  final void Function(File selectedImage) selectedImage;

  @override
  State<ImageInput> createState() {
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {
  File? _selectedImage;
  void _takePicture() async {
    final ImagePicker imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: double.infinity,
        maxHeight: double.infinity);

    if (pickedImage == null) {
      return;
    } else {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
      widget.selectedImage(File(pickedImage.path));
    }
  }

  void _removeAddedPicture() {
    setState(() {
      _selectedImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      icon: const Icon(Icons.camera),
      label: const Text('Take Picture'),
      onPressed: _takePicture,
    );

    if (_selectedImage != null) {
      content = Image.file(
        _selectedImage!,
        fit: BoxFit.cover,
      );
    }

    final shouldChange = _selectedImage != null
        ? Row(
            children: [
              TextButton(
                  onPressed: _takePicture,
                  child: const Text("Change uploaded image")),
              const Spacer(),
              TextButton(
                  onPressed: _removeAddedPicture,
                  child: const Text("Remove Image"))
            ],
          )
        : const Text("");

    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
            ),
          ),
          height: 250,
          width: double.infinity,
          alignment: Alignment.center,
          child: content,
        ),
        shouldChange
      ],
    );
  }
}
