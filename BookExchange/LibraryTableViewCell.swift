//
//  LibraryTableViewCell.swift
//  BookExchange
//
//  Created by zhangyunchen on 16/4/14.
//  Copyright © 2016年 zhangyunchen. All rights reserved.
//

import UIKit
import SDWebImage

class LibraryTableViewCell: UITableViewCell {
    
    //MARK:Properties
    @IBOutlet weak var bookCoverImageView: UIImageView!
    @IBOutlet weak var bookNameLabel: UILabel!
    @IBOutlet weak var bookDescriptionLabel: UILabel!
    @IBOutlet weak var donaterName: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func initWithBook(book:Book){
        bookNameLabel.text = book.bookName
        donaterName.text = "zyc"
        bookCoverImageView.image = UIImage(named: "placeHolder")
        if let url = book.bookCoverUrl {
            bookCoverImageView.sd_setImageWithURL(NSURL(string: url))
        }
        bookDescriptionLabel.text = book.bookDescription
    }

}
