import 'package:equatable/equatable.dart';
import '../model/book.dart';

enum SortType { author, title }

sealed class BookState extends Equatable {
  const BookState();

  @override
  List<Object?> get props => [];
}

class BooksLoadingState extends BookState {

}

class BooksListState extends BookState {
  final List<Book> books;
  final SortType sortType;
  const BooksListState(this.books, this.sortType);

  @override
  List<Object?> get props => [books, sortType];
}

class BooksDetailState extends BookState {
  final Book book;

  const BooksDetailState(this.book);

  @override
  List<Object?> get props => [book];
}