import 'package:flutter/material.dart';
import '../model/book.dart';
class BookCover extends StatelessWidget {
  final Book book;
  final double width;
  final double height;

  const BookCover({
    super.key,
    required this.book,
    this.width = 100.0,
    this.height = 166.67,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      book.imagePath,
      width: width,
      height: height,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stack) {
        return Container(
          width: width,
          height: height,
          color: Colors.grey[300],
          child: const Icon(Icons.menu_book),
        );
      },
    );
  }
}