//
//  AddBookDetailViewController.swift
//  BookExchange
//
//  Created by zhangyunchen on 16/4/24.
//  Copyright © 2016年 zhangyunchen. All rights reserved.
//

import UIKit
import SDWebImage
import APESuperHUD

class AddBookDetailViewController: UIViewController {
    
    //MARK: Properties
    var isbn:String?
    var bookDetail:BookDetail?
    @IBOutlet weak var bookCoverImageView: UIImageView!
    @IBOutlet weak var bookNameLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        APESuperHUD.showOrUpdateHUD(loadingIndicator: .Standard, message: "正在获取图书数据", presentingView: view)
        BookExchangeService.getBookDeailWithISBN(isbn){
            book in
            self.bookDetail = book
            dispatch_async(dispatch_get_main_queue()) {
                if let coverUrl = book.bookCoverUrl {
                    self.bookCoverImageView.sd_setImageWithURL(NSURL(string: coverUrl),placeholderImage: UIImage(named: "placeHolder"))
                }
                self.bookNameLabel.text = book.bookName
                APESuperHUD.removeHUD(animated: true, presentingView: self.view, completion: nil)
            }
        }
    }

    
    @IBAction func didSubmit(sender: AnyObject) {
        
        if let bookDetail = bookDetail{
            let book = bookDetail.getBook()
            APESuperHUD.showOrUpdateHUD(loadingIndicator: .Standard, message: "正在提交", presentingView: view)
            BookExchangeService.postBookToServer(book){
                success,error in
                APESuperHUD.removeHUD(animated: true, presentingView: self.view, completion: nil)
                if success {
                    APESuperHUD.showOrUpdateHUD(icon: .HappyFace, message: "提交成功", duration: 3.0, presentingView: self.view, completion: {
                        self.dismissViewControllerAnimated(true, completion: nil)
                    })
                }else{
                    APESuperHUD.showOrUpdateHUD(icon: .SadFace, message: "提交失败，请重试", duration: 3.0, presentingView: self.view, completion:nil)
                }
            }
        }
    }
    



}
