//
//  BookExchangeService.swift
//  BookExchange
//
//  Created by zhangyunchen on 16/4/23.
//  Copyright © 2016年 zhangyunchen. All rights reserved.
//

struct BookExchangeService {
    static func getBooks(reload:Bool,notice:Bool,response:([AnyObject]!,NSError!) -> ()){
        let query:AVQuery = AVQuery(className: "BookList")
        //        query.limit = 10
        //        query.skip = 1;
        query.findObjectsInBackgroundWithBlock (response)
        
    }
}
