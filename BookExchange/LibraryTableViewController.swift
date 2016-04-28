//
//  ViewController.swift
//  BookExchange
//
//  Created by zhangyunchen on 16/4/14.
//  Copyright © 2016年 zhangyunchen. All rights reserved.
//

import UIKit
import XWSwiftRefresh
import APESuperHUD

class LibraryTableViewController: UITableViewController {
    
    //MARK:Properties
    let InitIndentifier = "LibraryCell"
    var bookList:NSMutableArray = NSMutableArray()
    var page = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.headerView = XWRefreshNormalHeader(target: self, action:#selector(refresh))
        tableView.footerView = XWRefreshAutoNormalFooter(target: self, action: #selector(loadMore))
        APESuperHUD.showOrUpdateHUD(loadingIndicator: .Standard, message: "正在获取图书数据", presentingView:view)
        BookExchangeService.getBooks(false, notice: true,page: 1) { (objects, error) in
            APESuperHUD.removeHUD(animated: true, presentingView: self.view, completion: nil)
            if error != nil {
                APESuperHUD.showOrUpdateHUD(icon: .SadFace, message: "拉取数据失败，请稍后再试", duration: 3.0, presentingView: self.view, completion: nil)
            }else {
                for object in objects {
                    self.bookList.addObject(object)
                }
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
    
    
    func refresh(){
        tableView.headerView?.beginRefreshing()
        BookExchangeService.getBooks(false, notice: true,page: 1) { (objects, error) in
            self.tableView.headerView?.endRefreshing()
            if error != nil {
                print("there is someting worng " +  error.description)
            }else {
                self.page = 1
                self.bookList.removeAllObjects()
                for object in objects {
                    self.bookList.addObject(object)
                }
                print("get book success and book count is " + String(self.bookList.count))
                print(self.bookList)
                self.tableView.reloadData()
            }
        }
    }
    
    func loadMore(){
        tableView.footerView?.beginRefreshing()
        BookExchangeService.getBooks(false, notice: true,page: page + 1 ) { (objects, error) in
            self.tableView.footerView?.endRefreshing()
            if error != nil {
                print("there is someting worng " +  error.description)
            }else {
                self.page += 1
                for object in objects {
                    self.bookList.addObject(object)
                }
                print("get book success and book count is " + String(self.bookList.count))
                print(self.bookList)
                self.tableView.reloadData()
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ShowDetail" {
            let bookDetailViewController = segue.destinationViewController as! BookDetailViewController
            if let libraryTableViewCell = sender as? LibraryTableViewCell {
                let indexPath = tableView.indexPathForCell(libraryTableViewCell)!
                let bookAVObject = bookList[indexPath.row]
                bookDetailViewController.book = BookExchangeService.getBookFromAVOSObject(bookAVObject as! AVObject)
            }
        }
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

