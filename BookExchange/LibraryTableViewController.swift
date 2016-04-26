//
//  ViewController.swift
//  BookExchange
//
//  Created by zhangyunchen on 16/4/14.
//  Copyright © 2016年 zhangyunchen. All rights reserved.
//

import UIKit

class LibraryTableViewController: UITableViewController {
    
    //MARK:Properties
    let InitIndentifier = "LibraryCell"
    var bookList:NSArray = [AVObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        BookExchangeService.getBooks(false, notice: true,page: 1) { (objects, error) in
            if error != nil {
                print("there is someting worng " +  error.description)
            }else {
                self.bookList = objects
                print("get book success and book count is " + String(self.bookList.count))
                print(self.bookList)
                self.tableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: Table view delegate.
    
    // return number of sections in this tableview, and now we just need one.
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // return number of rows in one section, and it will be the hole number of books.
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookList.count
    }
    
    
    // return heigh of one row.
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 175
    }
    
    // return the cell of onew row
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let initIndentifier = "LibraryCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(initIndentifier, forIndexPath: indexPath) as! LibraryTableViewCell
        if indexPath.row < bookList.count {
            if let book = bookList[indexPath.row] as? AVObject {
                cell.initWithBook(BookExchangeService.getBookFromAVOSObject(book))
            }
        }
        return cell
    }


}

