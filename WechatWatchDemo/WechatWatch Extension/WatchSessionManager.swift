//
//  WatchSessionManager.swift
//  WechatWatch Extension
//
//  Created by akixie on 15/10/16.
//  Copyright © 2015年 Aki.Xie. All rights reserved.
//

import Foundation
import WatchConnectivity

protocol DataSourceChangedDelegate {
    func dataSourceDidUpdate(dataSource: AnyObject)
    func dataSourceDidReceiveUserInfo(dataSource: AnyObject)
}

class WatchSessionManager: NSObject, WCSessionDelegate {
    
    static let sharedManager = WatchSessionManager()
    private override init() {
        super.init()
    }

    private var dataSourceChangedDelegates = [DataSourceChangedDelegate]()
    
    private let session: WCSession = WCSession.defaultSession()
    
    func startSession() {
        session.delegate = self
        session.activateSession()
    }
    
    func addDataSourceChangedDelegate<T where T: DataSourceChangedDelegate, T: Equatable>(delegate: T) {
        dataSourceChangedDelegates.append(delegate)
    }
    
    func removeDataSourceChangedDelegate<T where T: DataSourceChangedDelegate, T: Equatable>(delegate: T) {
        for (index, indexDelegate) in dataSourceChangedDelegates.enumerate() {
            if let indexDelegate = indexDelegate as? T where indexDelegate == delegate {
                dataSourceChangedDelegates.removeAtIndex(index)
                break
            }
        }
    }
    
    // Sender
    func transferUserInfo(userInfo: [String : AnyObject]) -> WCSessionUserInfoTransfer? {
        return session.transferUserInfo(userInfo)
    }
    
    
}

// MARK: User Info
// use when your app needs all the data
// FIFO queue
//extension WatchSessionManager {
//
//    // Receiver
//    func session(session: WCSession, didReceiveUserInfo userInfo: [String : AnyObject]) {
//        // handle receiving user info
//        dispatch_async(dispatch_get_main_queue()) { [weak self] in
//
//            if let dataSource = self?.dataSource.insertItemFromData(userInfo) {
//                self?.dataSource = dataSource
//                self?.dataSourceChangedDelegates.forEach {
//                    $0.dataSourceDidUpdate(dataSource)
//                }
//            }
//        }
//    }
//
//}


// MARK: Application Context
// use when your app needs only the latest information
// if the data was not sent, it will be replaced
extension WatchSessionManager {
    
    // Receiver
    func session(session: WCSession, didReceiveApplicationContext applicationContext: [String : AnyObject]) {
        
        dispatch_async(dispatch_get_main_queue()) { [weak self] in
            self?.dataSourceChangedDelegates.forEach { $0.dataSourceDidUpdate(applicationContext)}
        }
        
    }
    
    func session(session: WCSession, didReceiveUserInfo userInfo: [String : AnyObject]){
        print(userInfo)
        
//        dispatch_async(dispatch_get_main_queue()) { [weak self] in
            self.dataSourceChangedDelegates.forEach { $0.dataSourceDidReceiveUserInfo(userInfo)}
//        }
        
    }
    
    
    
    
    
}