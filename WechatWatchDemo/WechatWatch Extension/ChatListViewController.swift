//
//  ChatListViewController.swift
//  WechatWatch Extension
//
//  Created by akixie on 15/10/16.
//  Copyright © 2015年 Aki.Xie. All rights reserved.
//

import Foundation
import WatchKit

class ChatListViewController:WKInterfaceController {
    var iconArray = ["listImage", "2", "3", "3", "2", "1"]
    var nameArray = ["张三", "李四", "王老五", "六六", "七月天", "阿德八约"]
    
    @IBOutlet weak var tableView: WKInterfaceTable!
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        
        [self .setupTable()]
        

    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func setupTable() {
        tableView.setNumberOfRows(nameArray.count, withRowType: "ChatListCell")
        for var i = 0; i < nameArray.count; ++i {
            
            let cell = tableView.rowControllerAtIndex(Int(i)) as? ChatListCell
            let nameText = nameArray[i]
            cell!.nameLabel.setText(nameText)
        }
    }
    
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        self.pushControllerWithName("ChatView", context: nameArray[rowIndex])
    }
}
