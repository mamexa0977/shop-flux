import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerGrid extends StatefulWidget {
  final List<File> images;
  final Function(List<File>) onImagesChanged;
  final int maxImages;

  const ImagePickerGrid({
    super.key,
    required this.images,
    required this.onImagesChanged,
    this.maxImages = 10,
  });

  @override
  State<ImagePickerGrid> createState() => _ImagePickerGridState();
}

class _ImagePickerGridState extends State<ImagePickerGrid> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImages() async {
    final List<XFile> picked = await _picker.pickMultiImage();
    final newImages = [...widget.images, ...picked.map((x) => File(x.path))];
    if (newImages.length > widget.maxImages) {
      // trim
      newImages.removeRange(widget.maxImages, newImages.length);
    }
    widget.onImagesChanged(newImages);
  }

  void _removeImage(int index) {
    final newImages = [...widget.images];
    newImages.removeAt(index);
    widget.onImagesChanged(newImages);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: [
        ...widget.images.asMap().entries.map((entry) {
          return Stack(
            children: [
              Image.file(entry.value, width: 80, height: 80, fit: BoxFit.cover),
              Positioned(
                right: 0,
                child: IconButton(
                  icon: const Icon(Icons.close, size: 20, color: Colors.red),
                  onPressed: () => _removeImage(entry.key),
                ),
              ),
            ],
          );
        }),
        if (widget.images.length < widget.maxImages)
          GestureDetector(
            onTap: _pickImages,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.add_photo_alternate),
            ),
          ),
      ],
    );
  }
}