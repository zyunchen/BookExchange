//
//  AddBookDetailViewController.swift
//  BookExchange
//
//  Created by zhangyunchen on 16/4/24.
//  Copyright © 2016年 zhangyunchen. All rights reserved.
//

import UIKit
import SDWebImage

class AddBookDetailViewController: UIViewController {
    
    //MARK: Properties
    var isbn:String?
    @IBOutlet weak var bookCoverImageView: UIImageView!
    @IBOutlet weak var bookNameLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        bookNameLabel.text = isbn
        BookExchangeService.getBookDeailWithISBN(isbn){
            book in
            dispatch_async(dispatch_get_main_queue()) {
                if let coverUrl = book.bookCoverUrl {
                    self.bookCoverImageView.sd_setImageWithURL(NSURL(string: coverUrl))
                }
                self.bookNameLabel.text = book.bookName
                
            }
        }
    }



}
