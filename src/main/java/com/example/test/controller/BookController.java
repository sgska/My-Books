package com.example.test.controller;

import com.example.test.model.Book;
import com.example.test.service.BookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.support.PagedListHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
public class BookController {
    private BookService bookService;

    @Autowired
    @Qualifier (value = "bookService")
    public void setBookService(BookService bookService) {
        this.bookService = bookService;
    }

    @RequestMapping(value = {"", "/index"}, method = RequestMethod.GET)
    public String index() {
        return "redirect:/books";
    }



    @RequestMapping(value = "books", method = RequestMethod.GET)
    public String listBooks(@RequestParam(required = false) Integer page, Model model) {
        model.addAttribute("book", new Book());
        model.addAttribute("randomBook", bookService.getRandomBook());
        List<Book> books = bookService.getBooks();
        setPaging(page, model, books);
        return "books";
    }

    @RequestMapping(value = "/books/add", method = RequestMethod.POST)
    public String addBook(@ModelAttribute("book") Book book) {
        if (book.getId() == 0) {
            if (book.getTitle().length() == 0) {
                book.setTitle("Auto generated name by ID " + (bookService.getBooks().get(bookService.getBooks().size() - 1).getId() + 1));
            }
            bookService.addBook(book);
        } else {
            bookService.updateBook(book);
        }
        return "redirect:/books";
    }


    @RequestMapping("remove/{id}")
    public String removeBook(@PathVariable("id") int id) {
        bookService.removeBook(id);

        return "redirect:/books";
    }

    @RequestMapping("bookdata/{id}")
    public String bookData(@PathVariable("id") int id, Model model) {
        Book book = this.bookService.getBookById(id);
        model.addAttribute("book", book);

        return "bookdata";
    }

    @RequestMapping("edit/{id}")
    public String editBook(@RequestParam(required = false) Integer page, @PathVariable("id") int id, Model model){
        Book book = this.bookService.getBookById(id);
        this.bookService.makeRead(book);
        model.addAttribute("book", book);
        List<Book> books = this.bookService.getBooks();
        setPaging(page, model, books);

        return "books";
    }

    @RequestMapping("makeread/{id}")
    public String makeRead(@RequestParam(required = false) Integer page, @PathVariable("id") int id, Model model) {
        Book book = bookService.getBookById(id);
        bookService.makeRead(book);

        return "redirect:/books";
    }

    @RequestMapping(value = "books/search")
    public String searchUser(@RequestParam("searchTitle") String searchTitle, Model model) {
        Book book = (Book) bookService.getBooksByName(searchTitle);
        model.addAttribute("book", book);

        return "bookdata";
    }

    private void setPaging(Integer page, Model model, List<Book> books) {
        PagedListHolder<Book> pagedListHolder = new PagedListHolder<Book>(books);
        pagedListHolder.setPageSize(10);

        model.addAttribute("maxPages", pagedListHolder.getPageCount());
        model.addAttribute("currentsort", "books");
        model.addAttribute("booksSize", books.size());

        if (page == null || page < 1 || page > pagedListHolder.getPageCount())
            page = 1;

        model.addAttribute("page", page);

        pagedListHolder.setPage(page - 1);
        model.addAttribute("listBooks", pagedListHolder.getPageList());
    }
}
