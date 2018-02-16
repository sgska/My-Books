package com.example.test.service;

import com.example.test.model.Book;

import java.util.List;

public interface BookService {
    void addBook(Book book);
    void updateBook(Book book);
    void removeBook(int id);
    void makeRead(Book book);
    Book getBookById(int id);
    List<Book> getBooks();
    Book getBooksByName(String searchText);
    Book getRandomBook();
}
