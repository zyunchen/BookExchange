//
//  BookDetail.swift
//  BookExchange
//
//  Created by zhangyunchen on 16/4/25.
//  Copyright © 2016年 zhangyunchen. All rights reserved.
//

class BookDetail {
    var bookCoverUrl:String?
    var bookName:String?
    var bookDonater:String?
    var bookDescription:String?
    var bookISBN:String?
    
    func getBook() -> Book{
        var book = Book()
        book.bookCoverUrl = bookCoverUrl
        book.bookDescription = bookDescription
        book.bookISBN = bookISBN
        book.bookName = bookName
        return book
    }
}
