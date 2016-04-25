//
//  Book.swift
//  BookExchange
//
//  Created by zhangyunchen on 16/4/16.
//  Copyright © 2016年 zhangyunchen. All rights reserved.
//

struct Book {
    var bookCoverUrl:String?
    var bookName:String?
    var bookDonater:String?
    var bookDescription:String?
    var bookISBN:String?
    
    struct AVOSConstant {
        static let bookCoverUrl = "BookCoverUrl"
        static let bookName = "BookName"
        static let bookDonater = "BookDonater"
        static let bookDescription = "BookDescription"
        static let bookISBN = "BookISBN"
    }
}
