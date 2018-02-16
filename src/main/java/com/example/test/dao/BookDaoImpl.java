package com.example.test.dao;

import com.example.test.model.Book;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class BookDaoImpl implements BookDao {
    private SessionFactory sessionFactory;
    private final static String SEARCH_QUERY = "from Book where title =:title";

    public void setSessionFactory(SessionFactory sessionFactory) {
        this.sessionFactory = sessionFactory;
    }

    @Override
    public void addBook(Book book) {
        Session session = sessionFactory.getCurrentSession();
        session.persist(book);
    }

    @Override
    @SuppressWarnings("unchecked")
    public Book getRandomBook() {
        Session session = sessionFactory.getCurrentSession();
        List<Book> books = session.createQuery("from Book").list();
        if (books.size() == 0) {
            books.add(new Book());
        }
        return books.get( (int)(Math.random() * books.size()));
    }

    @Override
    public void updateBook(Book book) {
        Session session = sessionFactory.getCurrentSession();
        book.setReadAlready(false);
        session.update(book);
    }

    @Override
    public void removeBook(int id) {
        Session session = sessionFactory.getCurrentSession();
        Book book = session.load(Book.class, id);
        if (book != null) {
            session.delete(book);
        }
    }

    @Override
    public void makeRead(Book book) {
        Session session = sessionFactory.getCurrentSession();
        if (!book.isReadAlready()) {
            book.setReadAlready(!book.isReadAlready());
        }
        session.update(book);
    }

    @Override
    public Book getBookById(int id) {
        Session session = sessionFactory.getCurrentSession();
        return session.load(Book.class, id);
    }

    @Override
    @SuppressWarnings("unchecked")
    public List<Book> getBooks() {
        Session session = sessionFactory.getCurrentSession();
        List<Book> books = session.createQuery("from Book").list();
        return books;
    }

    /*переделать поиск гавно*/
    @Override
    @SuppressWarnings("unchecked")
    public Book getBooksByName(String searchTitle) {
        Session session = sessionFactory.getCurrentSession();
        List<Book> books = (List<Book>) session.createQuery("from Book where title =:title")
                .setParameter("title", searchTitle)
                .list();
        if (books.size() == 0) {
            Book book = new Book();
            book.setDescription(searchTitle);
            return book;
        } else {
            return books.get(0);
        }


    }
}
