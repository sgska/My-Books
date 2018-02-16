package com.example.test.dao;

import com.example.test.model.Book;

import java.util.List;

public interface BookDao {
    void addBook(Book book);
    void updateBook(Book book);
    void removeBook(int id);
    void makeRead(Book book);
    Book getBookById(int id);
    List<Book> getBooks();
    Book getBooksByName(String searchTitle);

    Book getRandomBook();
}
