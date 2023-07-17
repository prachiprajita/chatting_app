import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({super.key, required this.onPickImage});

  final void Function(File pickedImage) onPickImage;

  @override
  State<UserImagePicker> createState() {
    return _UserImagePickerState();
  }
  
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImagefile;
  
  void _pickImage() async{
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.camera, 
      imageQuality: 50, maxWidth: 150,
    );
    if(pickedImage == null) {
      return;
    }

    setState(() {
      _pickedImagefile = File(pickedImage.path);
    });

    widget.onPickImage(_pickedImagefile!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey,
          foregroundImage: _pickedImagefile != null ? FileImage(_pickedImagefile!) : null,
        ),
        TextButton.icon(
          onPressed: _pickImage, 
          icon: const Icon(Icons.image), 
          label: Text(
            'Add image', 
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary
              ),
            ),
        ),
      ],
    );
  }
}