import 'package:equatable/equatable.dart';
import '../model/book.dart';
sealed class BookEvent extends Equatable {
  const BookEvent();

  @override
  List<Object> get props => [];
}

class LoadBooks extends BookEvent { //initial loading of books

}
class SortByAuthor extends BookEvent {//click on Author
  
}
class SortByTitle extends BookEvent {//click on Title
  
}
class SelectBookAndViewDetails extends BookEvent {//click on book to view details
  final Book book;

  const SelectBookAndViewDetails(this.book);

  @override
  List<Object> get props => [book];
}
class BackToList extends BookEvent {//back button to go back
  
}