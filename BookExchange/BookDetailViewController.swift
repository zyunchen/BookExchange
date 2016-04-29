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
    
    //MARK: Properties
    var book:Book?
    var bookDetail:BookDetail?
    @IBOutlet weak var bookCover: UIImageView!
    @IBOutlet weak var bookName: UILabel!
    @IBOutlet weak var bookDescription: UILabel!
    @IBOutlet weak var contentViewWidth: NSLayoutConstraint!
    @IBOutlet weak var contentViewHeight: NSLayoutConstraint!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var subbmitButton: UIButton!
    

    
    //MARK: Method
    override func viewDidLoad() {
        super.viewDidLoad()
        title = book?.bookName
        contentViewWidth.constant = UIScreen.mainScreen().bounds.width
        subbmitButton.layer.cornerRadius = 2
        
        if let url = book?.bookCoverUrl {
            bookCover.sd_setImageWithURL(NSURL( string: url),placeholderImage:UIImage(named: "placeHolder"))
        }
        bookName.text = book?.bookName
        bookDescription.text = book?.bookDescription
        
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
    
    @IBAction func didSubbmitPressed(sender: UIButton) {
        
    }
    

}
