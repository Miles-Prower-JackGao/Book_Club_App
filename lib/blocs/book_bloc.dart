import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/book.dart';
import 'book_event.dart';
import 'book_state.dart';

class BookBloc extends Bloc<BookEvent, BookState> {
  List<Book> booksList = [];
  SortType sortType = SortType.author;

  BookBloc() : super(BooksLoadingState()) {
    on<LoadBooks>(_onLoadBooks);
    on<SortByAuthor>((event, emit) async{
      await _onSort(SortType.author, emit);
    });
    on<SortByTitle>((event, emit) async{
      await _onSort(SortType.title, emit);
    });
    on<SelectBookAndViewDetails>((event, emit) {
      emit(BooksDetailState(event.book));
    });
    on<BackToList>((event, emit) {
      emit(BooksListState(List.of(booksList), sortType));
    });
    init();
  }
  void init() {
    booksList = [
      const Book(
        id: '1',
        title: 'Carmer and Grit, Book One: The Wingsnatchers',
        author: 'Sarah Jean Horwitz',
        description:
            'A stunning debut about a magician’s apprentice and a one-winged princess who must vanquish the mechanical monsters that stalk the streets and threaten the faerie kingdom. ',
        imagePath: 'assets/images/book1_cover.png',
      ),
      const Book(
        id: '2',
        title: 'Little Gods',
        author: 'Meng Jin',
        description:
            'Combining the emotional resonance of Home Fire with the ambition and innovation of Asymmetry, a lyrical and thought-provoking debut novel that explores the complex web of grief, memory, time, physics, history, and selfhood in the immigrant experience, and the complicated bond between daughters and mothers.',
        imagePath: 'assets/images/book2_cover.png',
      ),
      const Book(
        id: '3',
        title: 'A Clockwork Orange',
        author: 'Anthony Burgess',
        description:
            "A vicious fifteen-year-old droog is the central character of this 1963 classic. In Anthony Burgess's nightmare vision of the future, where the criminals take over after dark, the story is told by the central character, Alex, who talks in a brutal invented slang that brilliantly renders his and his friends' social pathology. A Clockwork Orange is a frightening fable about good and evil, and the meaning of human freedom. ",
        imagePath: 'assets/images/book3_cover.png',
      ),
      const Book(
        id: '4',
        title: 'The Imperfections Of Memory Vol.22',
        author: 'Angelina Aludo',
        description:
            'A collection built around the way memory fails us gently — what we keep, what we soften, and what we quietly let go.',
        imagePath: 'assets/images/book4_cover.png',
      ),
      const Book(
        id: '5',
        title: 'James and the Giant Peach',
        author: 'Roald Dahl',
        description:
            "James Henry Trotter lives with two ghastly hags. Aunt Sponge is enormously fat with a face that looks boiled and Aunt Spiker is bony and screeching. He's very lonely until one day something peculiar happens. . . At the end of the garden a peach starts to grow and GROW AND GROW. Inside that peach are seven very unusual insects - all waiting to take James on a magical adventure. But where will they go in their GIANT PEACH, and what will happen to the horrible aunts if they stand in their way? There's only one way to find out . . .",
        imagePath: 'assets/images/book5_cover.png',
      ),
      const Book(
        id: '6',
        title: 'The Big Deal: A 6-Step Formula to Kill Your Low Sales Stress and Help You to Close the Biggest Deals Ever',
        author: 'Hisham Al Gurg',
        description:
            "This book will show you in six easy to follow practical steps on how to never worry about low sales again, ever. I call them the 6 Ps System. I have used the exact same 6 Ps System to train all the sales teams in my 12 companies on how to sell big-ticket products to customers from all around the globe. I designed the 6 Ps System 20 years ago and my companies still use it today to sell high ticket products and services to large multinational organizations, and it still works perfectly. If you want to increase your chances of closes the next big deal, don't even try before reading this book.",
        imagePath: 'assets/images/book6_cover.png',
      ),
      const Book(
        id: '7',
        title: "Don't Look Back",
        author: 'Isaac Nelson',
        description:
            'Lorem ipsum dolor sit amet consectetur. Id tincidunt tristique vitae at pharetra. Commodo volutpat lacus adipiscing at elit semper eget turpis ut. Gravida faucibus faucibus ornare consectetur enim cursus tellus. Est varius vel egestas velit orci. Neque nam ultricies augue nunc vel pulvinar sed massa. Pellentesque netus pellentesque egestas aliquam maecenas amet libero integer. Ut eleifend platea massa diam ut. Egestas odio massa aliquet pellentesque quis laoreet sed. Sodales rhoncus nisi sit vel non leo ultricies ut facilisi. Adipiscing a augue id volutpat rhoncus in nec enim. In dictum egestas at dui. Quam quis consectetur nec id accumsan et fusce. Diam amet morbi lorem massa risus libero ac. Elit integer ut libero malesuada et tortor elementum porttitor. Arcu sed augue orci felis nam volutpat placerat. Sapien nulla diam fringilla ut vestibulum eget. Sodales id orci habitant at. Rhoncus pharetra eu posuere porttitor. Mauris odio vehicula eu orci consectetur dui sit varius. Laoreet sed viverra massa malesuada odio dictum justo quam quisque. Eros bibendum neque cras ut. Purus dolor ut pretium diam. Nunc lectus lacus sapien ultricies est pharetra. Sagittis eu rhoncus integer ridiculus morbi. Auctor in ultricies euismod sit in tincidunt velit aliquam. Egestas arcu et at feugiat elit risus et diam. Placerat urna sapien proin neque habitasse vivamus scelerisque. Id id cursus egestas nibh. Dictum non malesuada vitae proin. Nulla tempus odio tellus phasellus viverra ac sit dui ornare. Potenti a in massa iaculis faucibus in. Adipiscing posuere id blandit libero suspendisse. Suspendisse sed lobortis nec tellus. Velit adipiscing fames gravida nulla. Hac fermentum volutpat sit fusce sem pharetra orci. Odio facilisi dui turpis tortor mattis. Blandit faucibus ut tortor sed non vivamus venenatis. Cursus neque tortor in platea. Etiam fringilla vel tempor urna et sed placerat.',
        imagePath: 'assets/images/book7_cover.png',
      ),
    ];
    add(LoadBooks());
  }

  Future<void> _onLoadBooks(LoadBooks event, Emitter<BookState> emit) async{
    emit(BooksLoadingState());
    await Future.delayed(const Duration(milliseconds: 500));
    _handleSort();
    emit(BooksListState(List.of(booksList), sortType));
  }
  
  Future<void> _onSort(SortType type, Emitter<BookState> emit) async {
    sortType = type;
    emit(BooksLoadingState());
    await Future.delayed(const Duration(milliseconds: 300));
    _handleSort();
    emit(BooksListState(List.of(booksList), sortType));
  }

  void _handleSort() {
    booksList.sort((a, b) => sortType == SortType.author
        ? a.author.toLowerCase().compareTo(b.author.toLowerCase())
        : a.title.toLowerCase().compareTo(b.title.toLowerCase()));
  }
  
}