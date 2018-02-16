package com.example.test.service;

import com.example.test.model.Book;
import com.example.test.dao.BookDao;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class BookServiceImpl implements BookService {
    private BookDao bookDao;

    public void setBookDao(BookDao bookDao) {
        this.bookDao = bookDao;
    }

    @Override
    @Transactional
    public void addBook(Book book) {
        this.bookDao.addBook(book);
    }

    @Override
    @Transactional
    public void updateBook(Book book) {
        this.bookDao.updateBook(book);
    }

    @Override
    @Transactional
    public void removeBook(int id) {
        this.bookDao.removeBook(id);
    }

    @Override
    @Transactional
    public void makeRead(Book book) {
        this.bookDao.makeRead(book);
    }

    @Override
    @Transactional
    public Book getBookById(int id) {
        return this.bookDao.getBookById(id);
    }

    @Override
    @Transactional
    public List<Book> getBooks() {
        return this.bookDao.getBooks();
    }


    @Override
    @Transactional
    public Book getBooksByName(String searchTitle) {
        return this.bookDao.getBooksByName(searchTitle);
    }

    @Override
    @Transactional
    public Book getRandomBook() {
        return this.bookDao.getRandomBook();
    }
}
