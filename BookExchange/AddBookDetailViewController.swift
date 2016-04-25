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
    var bookDetail:BookDetail?
    @IBOutlet weak var bookCoverImageView: UIImageView!
    @IBOutlet weak var bookNameLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        bookNameLabel.text = isbn
        BookExchangeService.getBookDeailWithISBN(isbn){
            book in
            self.bookDetail = book
            dispatch_async(dispatch_get_main_queue()) {
                if let coverUrl = book.bookCoverUrl {
                    self.bookCoverImageView.sd_setImageWithURL(NSURL(string: coverUrl))
                }
                self.bookNameLabel.text = book.bookName
                
            }
        }
    }

    
    @IBAction func didSubmit(sender: AnyObject) {
        
        if let bookDetail = bookDetail{
            let book = bookDetail.getBook()
            BookExchangeService.postBookToServer(book)
        }
    }
    



}
