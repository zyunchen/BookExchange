//
//  BookDetailViewController.swift
//  BookExchange
//
//  Created by zhangyunchen on 16/4/28.
//  Copyright © 2016年 zhangyunchen. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {
    
    //MARK:Properties
    var book:Book?
    var bookDetail:BookDetail?

    override func viewDidLoad() {
        super.viewDidLoad()
        print(book?.bookName)
    }
    

}
