//
//  BookExchangeService.swift
//  BookExchange
//
//  Created by zhangyunchen on 16/4/23.
//  Copyright © 2016年 zhangyunchen. All rights reserved.
//

import Alamofire
import SwiftyJSON

struct BookExchangeService {
    
    struct funcPath {
        static let getBookDeatilWithISBN = "https://api.douban.com/v2/book/isbn/"
    }
    
    
    static func getBooks(reload:Bool,notice:Bool,page:Int,response:([AnyObject]!,NSError!) -> ()){
        let query:AVQuery = AVQuery(className: "BookList")
        query.limit = 10
        query.skip = 10 * (page - 1);
        query.orderByDescending("updatedAt")
        query.findObjectsInBackgroundWithBlock (response)
        
    }
    
    static func getBookDeailWithISBN(isbn:String?,completionHanlder:BookDetail -> Void){
        Alamofire.request(.GET, BookExchangeService.funcPath.getBookDeatilWithISBN + isbn!).responseJSON { response in
            if let response = response.result.value {
                print(response)
                let jsonData = JSON(response)
                completionHanlder(getBookDetailFromJson(jsonData))
            }
            
        }
    }
    
    static func postBookToServer(book:Book,completeHandler:(Bool,NSError?) -> Void){
        
        let post = AVObject(className: "BookList")
        post.setObject(book.bookCoverUrl, forKey: Book.AVOSConstant.bookCoverUrl)
        post.setObject(book.bookName, forKey: Book.AVOSConstant.bookName)
        post.setObject(book.bookDonater, forKey: Book.AVOSConstant.bookDonater)
        post.setObject(book.bookISBN, forKey: Book.AVOSConstant.bookISBN)
        post.setObject(book.bookDescription, forKey: Book.AVOSConstant.bookDescription)
        post.saveInBackgroundWithBlock { (succeeded, error) in
            completeHandler(succeeded,error)
        }
    }
    
    static func  getBookDetailFromJson(data:JSON) -> BookDetail{
        let book:BookDetail = BookDetail()
        book.bookName = data["title"].stringValue
        book.bookCoverUrl = data["image"].stringValue
        book.bookISBN = data["isbn13"].stringValue
        book.bookDescription = data["summary"].stringValue
        return book
    }
    
    static func  getBookFromAVOSObject(bookAVObject:AVObject) -> Book{
        var book = Book()
        book.bookCoverUrl = bookAVObject.objectForKey(Book.AVOSConstant.bookCoverUrl) as? String
        book.bookName = bookAVObject.objectForKey(Book.AVOSConstant.bookName) as? String
        book.bookDescription = bookAVObject.objectForKey(Book.AVOSConstant.bookDescription) as? String
        book.bookISBN = bookAVObject.objectForKey(Book.AVOSConstant.bookISBN) as? String
        return book
    }
    
    
}
