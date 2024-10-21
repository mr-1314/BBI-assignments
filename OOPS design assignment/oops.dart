void main() {
    Library library = Library('City Library');

    Book book1 = Book('B1', 'abc', 'Marathi', true);
    Book book2 = Book('B2', 'pqr', 'Hindi', true);
    Book book3 = Book('B3', 'xyz', 'English', true);

    library.addNewBook(book1);
    library.addNewBook(book2);
    library.addNewBook(book3);

    print('\n===== Available Books in the Library =====');
    library.showBooksList();

    Member member1 = Member('Abhishek', '4001');
    Member member2 = Member('Nikam', '4002');

    print('\n===== Borrowing Books =====');
    library.borrowBook(book1, member1);
    library.borrowBook(book2, member2);

    print('\n===== Borrowed Books List =====');
    library.showBorrowedBooks();

    print('\n===== Available Books List After Borrowing =====');
    library.showAvailableBooksList();

    print('\n===== Returning a Book =====');
    library.returnBook(book1, member1);

    print('\n===== Available Books List After Returning =====');
    library.showAvailableBooksList();
}

class Book {
    String _title;
    String _author;
    String _genre;
    bool _isAvailable;

    Book(this._title, this._author, this._genre, this._isAvailable);

    String get title => _title;
    String get author => _author;
    String get genre => _genre;
    bool get isAvailable => _isAvailable;

    set isAvailable(bool availability) {
        _isAvailable = availability;
    }
}

abstract class User {
    String _name;
    String _userId;

    User(this._name, this._userId);

    String get name => _name;
    String get userId => _userId;
}

class Member extends User {
    Member(String name, String userId) : super(name, userId);

    void borrowBook(Book book) {
        print('$name has borrowed the book: "${book.title}".');
    }

    void returnBook(Book book) {
        print('$name has returned the book: "${book.title}".');
    }
}

class Library {
    String _libraryName;
    List<Book> _booksList = [];
    List<BorrowDetails> _borrowedBooks = [];

    Library(this._libraryName);

    void addNewBook(Book book) {
        _booksList.add(book);
        print('Book "${book.title}" has been added to $_libraryName.');
    }

    void showBooksList() {
        print('List of books in $_libraryName:');
        for (var book in _booksList) {
            print('  - Title: ${book.title}');
            print('    Author: ${book.author}');
            print('    Genre: ${book.genre}');
            print('    Available: ${book.isAvailable ? "Yes" : "No"}\n');
        }
    }

    void borrowBook(Book book, Member member) {
        if (book.isAvailable) {
            _borrowedBooks.add(BorrowDetails(book, member));
            book.isAvailable = false;
            member.borrowBook(book);
        } else {
            print('Sorry, the book "${book.title}" is not available.');
        }
    }

    void returnBook(Book book, Member member) {
        BorrowDetails? borrowedDetail;

        for (var detail in _borrowedBooks) {
            if (detail.book.title == book.title && detail.member.userId == member.userId) {
                borrowedDetail = detail;
                break;
            }
        }

        if (borrowedDetail != null) {
            _borrowedBooks.remove(borrowedDetail);
            book.isAvailable = true;
            member.returnBook(book);
            print('The book "${book.title}" has been returned to the library.');
        } else {
            print('${member.name} did not borrow the book "${book.title}".');
        }
    }

    void showBorrowedBooks() {
        if (_borrowedBooks.isEmpty) {
            print('No books have been borrowed.');
        } else {
            print('List of borrowed books:');
            for (var borrow in _borrowedBooks) {
                print('  - Title: ${borrow.book.title}');
                print('    Borrowed by: ${borrow.member.name}\n');
            }
        }
    }

    void showAvailableBooksList() {
        bool hasAvailableBooks = false;
        print('Available books in $_libraryName:');
        for (var book in _booksList) {
            if (book.isAvailable) {
                print('  - Title: ${book.title}');
                print('    Author: ${book.author}');
                print('    Genre: ${book.genre}');
                hasAvailableBooks = true;
            }
        }
        if (!hasAvailableBooks) {
            print('  No books are currently available.');
        }
    }
}

class BorrowDetails {
    Book book;
    Member member;

    BorrowDetails(this.book, this.member);
}