//
//  BookDetailViewController.swift
//  BookExchange
//
//  Created by zhangyunchen on 16/4/28.
//  Copyright © 2016年 zhangyunchen. All rights reserved.
//

import UIKit
import APESuperHUD

class BookDetailViewController: UIViewController {
    
    //MARK:Properties
    var book:Book?
    var bookDetail:BookDetail?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = book?.bookName
        APESuperHUD.showOrUpdateHUD(loadingIndicator: .Standard, message: "正在获取图书数据", presentingView:view)
        BookExchangeService.getBookDeailWithISBN(book?.bookISBN){
            book in
            self.bookDetail = book
            dispatch_async(dispatch_get_main_queue()) {
                //update ui here
                APESuperHUD.removeHUD(animated: true, presentingView: self.view, completion: nil)
            }
        }
    }
    

}
