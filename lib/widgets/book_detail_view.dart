import 'package:flutter/material.dart';
import '../model/book.dart';
import 'book_cover.dart';

class BookDetailView extends StatelessWidget {
  final Book book;

  const BookDetailView({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BookCover(book:book, width: 200, height: 333.33),
          const SizedBox(height: 20.0),
          Text(
            book.title,
            style: textTheme.headlineMedium?.copyWith(color: Colors.grey[600]),
          ),
          const SizedBox(height: 12.0),
          Text(
            book.author,
            style: textTheme.titleLarge?.copyWith(color: Colors.grey[600]),
          ),
          const SizedBox(height: 16.0),
          Text(
            book.description,
            style: textTheme.bodyMedium?.copyWith(color: Colors.grey[600], height: 1.5),
          ),
        ],
      ),
    );
  }
}