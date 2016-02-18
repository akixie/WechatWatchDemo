//
//  ChatController.swift
//  WechatWatch Extension
//
//  Created by akixie on 15/10/16.
//  Copyright © 2015年 Aki.Xie. All rights reserved.
//

import Foundation
import WatchKit

class ChatController: WKInterfaceController {
    
    @IBOutlet weak var nameTitle: WKInterfaceLabel!

    @IBOutlet weak var textLabel: WKInterfaceLabel!
    
    @IBOutlet weak var tableView: WKInterfaceTable!
    
    var msgArray = Array<AnyObject>()
    var rowTypeArray = Array<String>()
    
    var numberOfRows: Int = 1
    
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
        let name = context as! String
        nameTitle.setText(name)
        
        self.msgArray = ["你好","你好","在干嘛","我在路上","是的", "NO","你在哪?","搞定了赶紧给我电话"]
        
        dispatch_async(dispatch_get_main_queue(), {
            self.setupTable(self.msgArray)
        })
        
    }
    
    
    func setupTable(messageArray:Array<AnyObject>) {
        numberOfRows = messageArray.count
        
//        numberOfRows = 5;
        
        //number for sumbit button row
        numberOfRows += 1
        
        self.rowTypeArray.removeAll()
        for var i = 0; i < numberOfRows; ++i {
            if(i==numberOfRows-1){
                rowTypeArray.append("SumitButtonRow")
            }else{
                if i % 2 == 0 {
                    rowTypeArray.append("MessageRightRow")
                }else{
                    rowTypeArray.append("MessageLeftRow")
                }
                
            }
        }
        self.tableView?.setRowTypes(rowTypeArray)
        
        for var j = 0; j < numberOfRows; ++j {
            
            if (j == numberOfRows - 1){
                
                if let row = tableView.rowControllerAtIndex(j) as? SumitButtonRow {
                        row.submitButton.setTitle("快速回复")
                }
                
            }else{
                let text = self.msgArray[j] as! String;
                if j % 2 == 0 {
                    if let row = tableView.rowControllerAtIndex(j) as? MessageRightRow  {
                        row.msgTextLabel.setText(text)
                    }
                    
                }else{
                    if let row = tableView.rowControllerAtIndex(j) as? MessageLeftRow {
                        row.msgTextLabel.setText(text)
                    }
                    
                }
                
            }
            
        }
        
        self.tableView.scrollToRowAtIndex(rowTypeArray.count-1)
        
    }
    
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        self.showMessageList()
        
    }

    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    
    @IBAction func showMessageList(){
        
        weak var wself = self
        let textChoices = ["在干嘛","OK","现在忙","我在路上","是的", "NO","你在哪?","搞定了","谢谢","我会在","赶紧给我电话","还活着"]
        
        self.presentTextInputControllerWithSuggestions(textChoices, allowedInputMode: WKTextInputMode.AllowEmoji, completion: {
            texts in
            if let texts = texts {
                if texts.count > 0 {
                    if let sself = wself{
                        let text = texts[0] as! String;
                        sself.textLabel.setText(text);
                    }
                    
                }
            }
        })

        
    }
    
    
    
    
}