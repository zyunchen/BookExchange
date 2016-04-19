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
    var cellForHeight:LibraryTableViewCell!

    override func viewDidLoad() {
        super.viewDidLoad()
        cellForHeight = tableView.dequeueReusableCellWithIdentifier(InitIndentifier) as! LibraryTableViewCell
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
        return 10
    }
    
    //return the estimated height for row
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 70
    }
    
    // return heigh of one row.
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return cellForHeight.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height
    }
    
    // return the cell of onew row
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let initIndentifier = "LibraryCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(initIndentifier, forIndexPath: indexPath) as! LibraryTableViewCell
        cell.donaterName.text = "zyc" + String(indexPath.row)
        return cell
    }


}

