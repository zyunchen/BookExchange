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
    
    
    static func getBooks(reload:Bool,notice:Bool,response:([AnyObject]!,NSError!) -> ()){
        let query:AVQuery = AVQuery(className: "BookList")
        //        query.limit = 10
        //        query.skip = 1;
        query.findObjectsInBackgroundWithBlock (response)
        
    }
    
    static func getBookDeailWithISBN(isbn:String?,completionHanlder:BookDetail -> Void){
        Alamofire.request(.GET, BookExchangeService.funcPath.getBookDeatilWithISBN + isbn!).responseJSON { response in
            if let response = response.result.value {
                print(response)
                let jsonData = JSON(response)
                print(jsonData)
                let book:BookDetail = BookDetail()
                book.bookName = jsonData["title"].stringValue
                book.bookCoverUrl = jsonData["image"].stringValue
                completionHanlder(book)
            }
            
        }
    }
    
    
}
