import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/book_bloc.dart';
import '../blocs/book_event.dart';
import '../blocs/book_state.dart';
import '../model/book.dart';
import '../widgets/book_cover.dart';
import '../widgets/book_detail_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white, 
      child: SafeArea(
        bottom: false,
        child: BlocBuilder<BookBloc, BookState>(
            builder: (context, state) {
              if (state is BooksLoadingState) {
                return const _LoadingPage();
              } else if (state is BooksListState) {
                return _ListBookPage(books: state.books, sortType: state.sortType);
              } else if (state is BooksDetailState) {
                return _BookDetailPage(book: state.book);
              } 
              return const _LoadingPage();
            },
        ),
      ),
    );
  }
}

PreferredSizeWidget _buildAppBar(BuildContext context,{required String title, required Widget leading}) {
  return AppBar(
    backgroundColor: const Color(0xFFFEF7FF),
    centerTitle: true,
    leading: leading,
    title: Text(title),
    actions: [
      IconButton(
        icon: const Icon(Icons.account_circle_outlined),
        onPressed: () {},
      ),
    ],
  );
}

Widget _menuButton(){
  return IconButton(
    icon: const Icon(Icons.menu),
    onPressed: () {},
  );
}
class _LoadingPage extends StatelessWidget {
  const _LoadingPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(
        context,
        title: 'Book Club Home',
        leading: _menuButton(),
      ),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _ListBookPage extends StatelessWidget {
  final List<Book> books;
  final SortType sortType;

  const _ListBookPage({required this.books, required this.sortType});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<BookBloc>();
    return Scaffold(
      appBar: _buildAppBar(
        context,
        title: 'Book Club Home',
        leading: _menuButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Sort by',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 8.0),
                ChoiceChip(
                  label: const Text('Author'),
                  selected: sortType == SortType.author,
                  showCheckmark: false,
                  backgroundColor: Colors.white,
                  onSelected: (_) {
                    bloc.add(SortByAuthor());
                  },
                ),
                const SizedBox(width: 8.0),
                ChoiceChip(
                  label: const Text('Title'),
                  selected: sortType == SortType.title,
                  showCheckmark: false,
                  backgroundColor: Colors.white,
                  onSelected: (_) {
                    bloc.add(SortByTitle());
                  },
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text('Books', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8.0),
            SizedBox(
              height: 166.67,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: books.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8.0),
                itemBuilder: (context, index) {
                  final book = books[index];
                  return GestureDetector(
                    onTap: () {
                      bloc.add(SelectBookAndViewDetails(book));
                    },
                    child: BookCover(book: book),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BookDetailPage extends StatelessWidget {
  final Book book;

  const _BookDetailPage({required this.book});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<BookBloc>();
    return PopScope(
      canPop: false,
      onPopInvokedWithResult:(didPop, _){
        if(!didPop){
          bloc.add(BackToList());
        }
      },
      child: Scaffold(
        appBar: _buildAppBar(
          context,
          title: 'Book Detail',
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              bloc.add(BackToList());
            },
          ),
        ),
        body: BookDetailView(book: book),
      ),
    );
  }
}