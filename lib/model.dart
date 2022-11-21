import 'dart:io';
import 'dart:typed_data';

class Notes {
  int? id;
  String title;
  String details;
  String? image;

  Notes({
    this.id,
    required this.details,
    required this.title,
    this.image,
  });
}
