import 'package:flutter/foundation.dart';

class Brands {
  final int id;
  final String name;
  final String? image;

  const Brands({
    required this.id,
    required this.name,
     this.image,
  });
}
